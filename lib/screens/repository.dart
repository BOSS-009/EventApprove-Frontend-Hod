import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hod_app/main.dart';
import 'package:hod_app/screens/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Repository {
  Dio dio = Dio();

  // Constructor to initialize Dio instance
  Future<List<Map<String, dynamic>>> fetchEvents(String eventType) async {
    final String apiUrl =
        '${config.baseURL}/centralized'; // Replace with your API URL
    Dio dio = Dio();

    try {
      // Make GET request with query parameters
      final response = await dio.get(
        apiUrl,
        queryParameters: {'event_type': eventType},
      );

      // Check response status
      if (response.statusCode == 200) {
        // Decode JSON response
        final List<dynamic> responseData = response.data;

        // Map to a list of events
        return responseData
            .map((event) => event as Map<String, dynamic>)
            .toList();
      } else {
        // Handle non-200 responses
        throw Exception('Failed to fetch events: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching events: $e');
      return [];
    }
  }

  Future<void> updateEventApproval(int masterId, bool approval) async {
    final Dio dio = Dio();

    try {
      // Create the request payload
      final data = {
        'master_id': masterId,
        'approval': approval,
      };

      // Configure Dio (e.g., base URL, headers)
      dio.options.baseUrl = config.baseURL; // Replace with your API base URL
      dio.options.headers = {
        'Content-Type': 'application/json',
      };

      // Make the PUT request
      final response = await dio.put(
        '/centralized', // Replace with your endpoint (e.g., '/update-event-approval')
        data: data,
      );

      // Handle response
      if (response.statusCode == 200) {
        print('Approval updated successfully: ${response.data}');
      } else {
        print('Failed to update approval: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error updating approval: $e');
    }
  }

  Future<void> deleteEvent(int masterId) async {
    final Dio dio = Dio();

    try {
      // Configure Dio (e.g., base URL, headers)
      dio.options.baseUrl =
          '${config.baseURL}/centralized'; // Replace with your API base URL
      dio.options.headers = {
        'Content-Type': 'application/json',
      };

      // Make the DELETE request
      final response = await dio.delete(
        '/$masterId', // Replace with your endpoint (e.g., '/delete-event/{master_id}')
      );

      // Handle response
      if (response.statusCode == 200) {
        print('MasterEvent deleted successfully: ${response.data}');
      } else {
        print('Failed to delete event: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  Future<List<dynamic>> getAllMasterEvents() async {
    final Dio dio = Dio();

    try {
      // Configure Dio (e.g., base URL, headers)
      dio.options.baseUrl =
          '${config.baseURL}/centralized'; // Replace with your API base URL
      dio.options.headers = {
        'Content-Type': 'application/json',
      };

      // Make the GET request
      final response = await dio.get('/all');

      // Handle response
      if (response.statusCode == 200) {
        List<dynamic> masterEvents = response.data;
        print('Master Events fetched successfully: $masterEvents');
        return masterEvents;
      } else {
        print('Failed to fetch events: ${response.statusMessage}');
      }
      return [];
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getEventByMasterId(int masterId) async {
    try {
      final dio = Dio();
      // Replace with your base URL
      dio.options.baseUrl = '${config.baseURL}/centralized';

      final response = await dio.get('/$masterId');

      if (response.statusCode == 200) {
        // The API returns a JSON object, so we'll return it as Map<String, dynamic>
        return response.data as Map<String, dynamic>;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: 'Failed to fetch event data',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw 'Event not found';
      }
      throw 'Error fetching event: ${e.message}';
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  Future<List<Map<String, dynamic>>> fetchProposals() async {
    try {
      final String endpoint = "${config.baseURL}/event";
      final response = await Dio().get(endpoint);
      final List eventsJson = response.data['events'];

      return eventsJson.map((json) => json as Map<String, dynamic>).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching events: $e");
      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchConference() async {
    try {
      final String endpoint = "${config.baseURL}/conference";
      final response = await Dio().get(endpoint);
      print('$response');
      final List conferenceJson = response.data['conferences'];

      return conferenceJson
          .map((json) => json as Map<String, dynamic>)
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching conferences: $e");
      }
      rethrow;
    }
  }

  // PUT request to update the request status (Accept/Reject)
  Future<Map<String, dynamic>> updateRequestStatus(
      int eventID, bool status) async {
    final url =
        '${config.baseURL}/event/approval/$eventID'; // Endpoint for updating a specific request

    // Data to send with PUT request
    Map<String, dynamic> data = {
      'approval': status,
    };

    try {
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response.
        return response.data;
      } else {
        // If the server returns a non-200 response, throw an error
        throw Exception('Failed to update request status');
      }
    } catch (e) {
      throw Exception('Error during PUT request: $e');
    }
  }

  Future<Map<String, dynamic>> updateConferenceStatus(
      int conferenceId, bool status) async {
    final url =
        '${config.baseURL}/conference/approval/$conferenceId'; // Endpoint for updating a specific request

    // Data to send with PUT request
    Map<String, dynamic> data = {
      'approval': status,
    };

    try {
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response.
        return response.data;
      } else {
        // If the server returns a non-200 response, throw an error
        throw Exception('Failed to update request status');
      }
    } catch (e) {
      throw Exception('Error during PUT request: $e');
    }
  }

  Future<Map<String, dynamic>> deleteRequest(int eventID) async {
    final url = '${config.baseURL}/event/$eventID';

    try {
      final response = await dio.delete(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response.
        return response.data;
      } else {
        // If the server returns a non-200 response, throw an error
        throw Exception('Failed to update request status');
      }
    } catch (e) {
      throw Exception('Error during PUT request: $e');
    }
  }

  Future<Map<String, dynamic>> deleteConference(int conferenceId) async {
    final url = '${config.baseURL}/conference/$conferenceId';

    try {
      final response = await dio.delete(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response.
        return response.data;
      } else {
        // If the server returns a non-200 response, throw an error
        throw Exception('Failed to update request status');
      }
    } catch (e) {
      throw Exception('Error during PUT request: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      // Fetch proposals and conferences concurrently
      // final proposals = await fetchProposals();
      final conferences = await fetchConference();

      // Merge both lists of maps into a single list
      List<Map<String, dynamic>> mergedData = [];

      // Add 'submissionType' to each proposal
      // for (var proposal in proposals) {
      //   proposal['submissionType'] = 'proposal';  // Add 'submissionType' field
      //   mergedData.add(proposal);
      // }

      // Add 'submissionType' to each conference
      for (var conference in conferences) {
        conference['submissionType'] =
            'conference'; // Add 'submissionType' field
        mergedData.add(conference);
      }

      return mergedData;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
      rethrow;
    }
  }

  Future<void> validateLogin(
      BuildContext context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username and Password cannot be empty")),
      );
      return;
    }

    try {
      // Make the API call
      final response = await http.post(
        Uri.parse(
            '${config.baseURL}/centralized/login'), // Replace with your API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': 'HOD', // Replace with the role you need
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Save user details locally
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('hod', jsonEncode(data['user']));
        await prefs.setBool('isLogged', true);

        // Navigate to Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    username: data['user']['username'],
                  )),
        );
      } else {
        final error = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? "Invalid credentials")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  Future<void> registerUser(
      BuildContext context, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${config.baseURL}/centralized/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': 'HOD',
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<bool> pingServer(String ip) async {
    try {
      final response = await http.get(
        Uri.parse('http://$ip:5001/centralized/ping'),
      );

      if (response.statusCode == 200) {
        return true; // Server is reachable
      }
    } catch (e) {
      print('Error pinging server: $e');
    }
    return false; // Server unreachable
  }
}

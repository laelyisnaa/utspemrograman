import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting OSIS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Candidate> candidates = [
    Candidate(name: 'Kandidat 1', role: 'Ketua OSIS'),
    Candidate(name: 'Kandidat 2', role: 'Ketua OSIS'),
    Candidate(name: 'Kandidat 3', role: 'Wakil Ketua OSIS'),
    Candidate(name: 'Kandidat 4', role: 'Wakil Ketua OSIS'),
  ];

  final Set<String> votedCandidates = {};

  void _vote(String candidateName) {
    if (!votedCandidates.contains(candidateName)) {
      setState(() {
        votedCandidates.add(candidateName);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Anda memilih $candidateName'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Anda sudah memilih $candidateName'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting Ketua dan Wakil Ketua OSIS'),
      ),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          final hasVoted = votedCandidates.contains(candidate.name);

          return ListTile(
            title: Text(candidate.name),
            subtitle: Text(candidate.role),
            trailing: ElevatedButton(
              onPressed: hasVoted ? null : () => _vote(candidate.name),
              child: Text(hasVoted ? 'Sudah Vote' : 'Vote'),
            ),
          );
        },
      ),
    );
  }
}

class Candidate {
  final String name;
  final String role;

  Candidate({required this.name, required this.role});
}

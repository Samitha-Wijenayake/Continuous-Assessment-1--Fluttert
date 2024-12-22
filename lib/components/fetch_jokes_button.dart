import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';

class FetchJokesButton extends StatelessWidget {
  final JokeState jokeState;

  const FetchJokesButton({super.key, required this.jokeState});

  @override
  Widget build(BuildContext context) {
    return Consumer<JokeState>(
      builder: (context, jokeState, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: jokeState.isLoading ? null : () => _fetchJokes(context),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.all(0), // No padding to the button itself
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Match card radius
              ),
              backgroundColor: Colors.transparent, // Transparent button
              elevation: 0, // No shadow
            ),
            child: Container(
              height: 60.0, // Increased height for the button
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade300, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white, // Match border styling
                  width: 2.0,
                ),
              ),
              child: Center(
                child: jokeState.isLoading
                    ? const SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Fetch Jokes",
                        style: TextStyle(
                          color: Colors.white, // Match text color
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _fetchJokes(BuildContext context) {
    jokeState.fetchJokes(context);
  }
}

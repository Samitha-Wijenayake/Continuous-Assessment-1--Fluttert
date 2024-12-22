import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';
import '../components/fetch_jokes_button.dart';
import '../components/joke_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jokeState = Provider.of<JokeState>(context);

    if (!jokeState.isLoading && jokeState.jokes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400 * jokeState.sizeRatio,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade400, Colors.deepPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Your Daily Dose of Jokes',
                      style: TextStyle(
                        fontSize: 50 * jokeState.sizeRatio,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LobsterTwo-Bold',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 16.0),
          //   child: Text(
          //     "Select a Joke Category",
          //     style: TextStyle(
          //       fontFamily: 'LobsterTwo-Italic',
          //       fontSize: 18,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.deepPurple,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Material(
          //     elevation: 4,
          //     shadowColor: Colors.deepPurple.withOpacity(0.3),
          //     borderRadius: BorderRadius.circular(10),
          //     child: JokeCategoryDropdown(jokeState: jokeState),
          //   ),
          // ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FetchJokesButton(jokeState: jokeState),
          ),
          const SizedBox(height: 20),
          if (!jokeState.isLoading && jokeState.jokes.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "No jokes fetched yet!",
                  style: TextStyle(
                    fontFamily: 'Lato-Italic',
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                jokeState.fetchJokes(context);
              },
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: jokeState.jokes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Material(
                        elevation: 6,
                        shadowColor: const Color.fromARGB(255, 148, 109, 58)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple
                                .shade50, // Light purple background for the card
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: JokeCard(joke: jokeState.jokes[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

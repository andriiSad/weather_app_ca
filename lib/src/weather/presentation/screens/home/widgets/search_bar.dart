import 'package:flutter/material.dart';

class SearhBar extends StatefulWidget {
  const SearhBar({super.key});

  @override
  State<SearhBar> createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _inputController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Start typing to search...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // Remove the text field underline
                  border: InputBorder.none,
                  // Optionally, you can also remove the outline when focused
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              shape: const CircleBorder(),
              child: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';// this import is to know which platform im working

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/model/expense.dart';

import '../main.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    // TODO: implement createState
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime?
  _selectedDate; //? means it can be null so he can open and close the picker without picking any date
  Category _selectedCategory = Category.leisure;

  // if i have x fields i have x controller
  //i should always clear the Text EditingController  when i close the form it should be cleaned
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      // we use await when we need the user to
      // finish his work then do step 2
      //showDatePicker return future date picked so i need await
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
    print(pickedDate); // This will print "Instance of 'Future<DateTime?>'"
    // if we don't use await the print will be executed before the user pick a time
  }

  @override
  void dispose() {
    //dispose used to delete the data inserted
    // when cancelling and going out of a model
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          actions: [
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer, // or any color you want
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
          content: const Text(
            'Please make sure a valid title, catalogue  that was entered',
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          actions: [
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer, // or any color you want
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
          content: const Text(
            'Please make sure a valid title, catalogue  that was entered',
          ),
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // Cupertino used for ios iphone dialog alert
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        category: _selectedCategory,
        title: _titleController.text,
        amounts: enteredAmount,
        date: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      // we use layout builder to return
      // different widget based on constraints
      // we use it for responsiveness and here im using it to adjust my app model
      // if chosen in landscape mode
      builder: (ctx, constraints) {
        print(constraints);
        print(constraints.minHeight);
        print(constraints.maxHeight);
        print(constraints.minWidth);
        print(constraints.maxWidth);
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
              child: Column(
                children: [
                  // handling landscape mode
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // place children at the top of
                      // the vertical axis
                      // image for each child vertical axis it will be in the top of the axis |` |`
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: InputDecoration(
                              label: const Text('Title'),
                              labelStyle: TextStyle(
                                color: kColorScheme.onPrimary, // label color
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kColorScheme.onPrimary,
                                  width: 2,
                                ), // when focused
                              ),
                              floatingLabelStyle: TextStyle(
                                color: kColorScheme.onPrimary,
                              ),
                            ),
                            style: TextStyle(color: kColorScheme.onPrimary),
                            cursorColor: kColorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          // we use expanded to tell the widget to take all space available from the parent
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$',
                              labelStyle: TextStyle(
                                color: kColorScheme.onPrimary, // label color
                              ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: kColorScheme.onPrimary), // default border
                              // ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kColorScheme.onPrimary,
                                  width: 2,
                                ), // when focused
                              ),
                              floatingLabelStyle: TextStyle(
                                color: kColorScheme
                                    .onPrimary, // when label floats above
                              ),
                            ),
                            style: TextStyle(color: kColorScheme.onPrimary),
                            // text inside the field
                            cursorColor:
                                kColorScheme.onPrimary, //prefix means sign
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      //onChanged: _saveTitleInput,
                      //using controller no need for onchange
                      controller: _titleController,
                      //call back function is a function sent in parameteer like
                      //void greetSomeone(void Function(String) callback) {
                      //   callback("Abdallah"); // The function is called here
                      // } and on changed is afunction that take in here parameter callback function
                      //       onChanged expects a callback function that takes one String parameter — the current value of the TextField after each change.
                      //   When you pass _saveTitleInput without parentheses (_saveTitleInput not _saveTitleInput()), Flutter doesn’t call it immediately — it passes the function reference to the TextField widget.
                      // Whenever the user types something, Flutter calls that function automatically, giving it the latest text as the argument.
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: const Text('Title'),
                        labelStyle: TextStyle(
                          color: kColorScheme.onPrimary, // label color
                        ),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: kColorScheme.onPrimary), // default border
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kColorScheme.onPrimary,
                            width: 2,
                          ), // when focused
                        ),
                        floatingLabelStyle: TextStyle(
                          color:
                              kColorScheme.onPrimary, // when label floats above
                        ),
                      ),
                      style: TextStyle(color: kColorScheme.onPrimary),
                      // text inside the field
                      cursorColor: kColorScheme.onPrimary,
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          //controller is not supported inside dropdown
                          // category is enum Static / known values → enum
                          value: _selectedCategory,
                          dropdownColor: Theme.of(context).colorScheme.primary,

                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),

                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            print(value);
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'no day selected'
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              //if selected put it if not put no date selected
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          // we use expanded to tell the widget to take all space available from the parent
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$',
                              labelStyle: TextStyle(
                                color: kColorScheme.onPrimary, // label color
                              ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: kColorScheme.onPrimary), // default border
                              // ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kColorScheme.onPrimary,
                                  width: 2,
                                ), // when focused
                              ),
                              floatingLabelStyle: TextStyle(
                                color: kColorScheme
                                    .onPrimary, // when label floats above
                              ),
                            ),
                            style: TextStyle(color: kColorScheme.onPrimary),
                            // text inside the field
                            cursorColor:
                                kColorScheme.onPrimary, //prefix means sign
                          ),
                        ),

                        const SizedBox(width: 12),
                        // for spacing only between widgets
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'no day selected'
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              //if selected put it if not put no date selected
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            ); //Navigator.pop() remove the model from the screen
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          //controller is not supported inside dropdown
                          // category is enum Static / known values → enum
                          value: _selectedCategory,
                          dropdownColor: Theme.of(context).colorScheme.primary,

                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),

                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            print(value);
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            ); //Navigator.pop() remove the model from the screen
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    ),

                  //     Category.values is a List<Category>.
                  // Example: [Category.food, Category.sport, Category.music]
                  //
                  //     After .map(...), you now have an Iterable<DropdownMenuItem<Category>>.
                  // Each Category is transformed into a DropdownMenuItem.
                  //
                  // Finally, .toList() converts that iterable into a List<DropdownMenuItem<Category>>, which is what DropdownButton.items expects.
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';

/// Available Virtual Keyboard Types:
/// [Numeric] - [Numeric] only.
/// [Alphanumeric] - [Alphanumeric]: letters`[A-Z]` + numbers`[0-9]` + `@` + `.`.
enum VirtualKeyboardType { numeric, alpha_numeric }




/// Type for virtual keyboard key.
///
/// [Action] - Can be action key - Return, Backspace, etc.
///
/// [String] - Keys that have text value - `Letters`, `Numbers`, `@` `.`
enum VirtualKeyType { action, string }



/// [VirtualKeyboard] actions.
enum VirtualKeyboardKeyAction { backspace, enter, shift, space }


/// [VirtualKeyboard] key
class VirtualKey {
	final String text;
	final String capsText;
	final VirtualKeyType keyType;
	final VirtualKeyboardKeyAction action;

	VirtualKey(
			{this.text, this.capsText, @required this.keyType, this.action});
}


/// Keys for [AlphaNumeric] Keyboard's rows.
const List<List> keyRows = [
	// Row 1
	const [
		'1',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
		'0',
	],
	// Row 2
	const [
		'q',
		'w',
		'e',
		'r',
		't',
		'y',
		'u',
		'i',
		'o',
		'p',
	],
	// Row 3
	const [
		'a',
		's',
		'd',
		'f',
		'g',
		'h',
		'j',
		'k',
		'l',
	],
	// Row 4
	const [
		'z',
		'x',
		'c',
		'v',
		'b',
		'n',
		'm',
	],
	// Row 5
	const [
		'.',
	]
];

/// Keys for [Numeric] Keyboard's rows.
const List<List> keyRowsNumeric = [
	// Row 1
	const [
		'1',
		'2',
		'3',
	],
	// Row 1
	const [
		'4',
		'5',
		'6',
	],
	// Row 1
	const [
		'7',
		'8',
		'9',
	],
	// Row 1
	const [
		'0',
	],
];
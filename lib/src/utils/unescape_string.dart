/// Unescapes a string.
String unescape(String i) {
  var input = i;
  final sb = StringBuffer();

  while (input.isNotEmpty) {
    final index = input.indexOf(r'\');
    // No escaped characters
    if (index == -1) {
      sb.write(input);
      break;
    }
    sb.write(input.substring(0, index));
    // Forward slash at the end of text. Ignore.
    if (index == input.length - 1) {
      break;
    }
    final select = String.fromCharCode(input.codeUnitAt(index + 1));
    input = input.substring(index + 2);
    switch (select) {
      case r'\':
        sb.write(r'\');
      case 't':
        sb.write('\t');
      case 'r':
        sb.write('\r');
      case 'n':
        sb.write('\n');
      case 'f':
        sb.write('\f');
      case 'b':
        sb.write('\b');
      case 'v':
        sb.write('\v');
      case 'u':
        if (input.length < 4) {
          input = '';
          break;
        }
        if (input[0] != '{') {
          final digit = input.substring(0, 4);
          final intDigit = int.tryParse(digit, radix: 16);
          if (intDigit == null || intDigit < 0) {
            break;
          }
          input = input.substring(4);
          sb.writeCharCode(intDigit);
        } else {
          final match = RegExp('{([a-zA-Z0-9]+)}').matchAsPrefix(input);
          if (match == null) {
            break;
          } else {
            input = input.substring(match.end);
            final digit = match[1]!;
            final intDigit = int.tryParse(digit, radix: 16);
            if (intDigit == null || intDigit < 0) {
              break;
            }
            sb.writeCharCode(intDigit);
          }
        }
      case 'x':
        if (input.length < 2) {
          input = '';
          break;
        }
        final digit = input.substring(0, 2);
        input = input.substring(2);
        final intDigit = int.tryParse(digit, radix: 16);
        if (intDigit == null || intDigit < 0) {
          break;
        }
        sb.writeCharCode(intDigit);
      default:
        sb.write(select);
        break;
    }
  }

  return sb.toString();
}

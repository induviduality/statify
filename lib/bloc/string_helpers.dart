// Misc Helper to format strings
// Adds ellipsis to strings that are too long
String truncateString(String data, int length) {
  return (data.length >= length) ? '${data.substring(0, length)}...' : data;
}
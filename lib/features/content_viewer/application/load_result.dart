import '../domain/content_piece.dart';

class LoadResult {
  final List<ContentPiece> pieces;
  final List<String> skippedLarge;
  const LoadResult(this.pieces, this.skippedLarge);
}

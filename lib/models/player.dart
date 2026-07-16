class Player {
  final int number;
  final String name;
  final String position;
  final String? time;
  final bool submitted;
  final int? sleep;
  final int? energy;
  final int? mood;
  final int? soreness;
  final bool? hasPain;
  final String? painNote;


  const Player({
    required this.number,
    required this. name,
    required this.position,
    this.time,
    required this.submitted,
    this.sleep,
    this.energy,
    this.mood,
    this.soreness,
    this.hasPain,
    this.painNote
  });


  int? get readinessPercent {
    if (!submitted || sleep == null || energy == null || mood == null ||soreness == null) {
      return null;
    }

    final invertedSoreness = 6 - soreness!;
    final average = (sleep! + energy! + mood! + invertedSoreness) / 4;
    var percent = ((average - 1)/ 4 * 100).round();

    if (hasPain == true) {
        percent = percent > 50 ? 50 : percent;
    }
    return percent;

  }
}
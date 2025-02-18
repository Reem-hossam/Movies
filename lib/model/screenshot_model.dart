class ScreenShot {
  List<Backdrops>? backdrops;
  int? id;
  List<Logos>? logos;
  List<Posters>? posters;

  ScreenShot({this.backdrops, this.id, this.logos, this.posters});

  ScreenShot.fromJson(Map<String, dynamic> json) {

    backdrops = (json['backdrops'] as List?)?.map((v) => Backdrops.fromJson(v)).toList() ?? [];
    id = json['id'] ?? 0;
    logos = (json['logos'] as List?)?.map((v) => Logos.fromJson(v)).toList() ?? [];
    posters = (json['posters'] as List?)?.map((v) => Posters.fromJson(v)).toList() ?? [];

    print("✅ Loaded ${backdrops?.length} backdrops!");
  }


  Map<String, dynamic> toJson() {
    return {
      if (backdrops != null) 'backdrops': backdrops!.map((v) => v.toJson()).toList(),
      'id': id,
      if (logos != null) 'logos': logos!.map((v) => v.toJson()).toList(),
      if (posters != null) 'posters': posters!.map((v) => v.toJson()).toList(),
    };
  }
}

class Backdrops {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Backdrops({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = (json['aspect_ratio'] as num?)?.toDouble();
    height = json['height'] as int?;
    iso6391 = json['iso_639_1'] as String?;
    filePath = json['file_path'] as String?;
    voteAverage = (json['vote_average'] as num?)?.toDouble();
    voteCount = json['vote_count'] as int?;
    width = json['width'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (height != null) 'height': height,
      if (iso6391 != null) 'iso_639_1': iso6391,
      if (filePath != null) 'file_path': filePath,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (width != null) 'width': width,
    };
  }
}

class Logos {
  String? filePath;

  Logos({this.filePath});

  Logos.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      if (filePath != null) 'file_path': filePath,
    };
  }
}

class Posters {
  String? filePath;

  Posters({this.filePath});

  Posters.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      if (filePath != null) 'file_path': filePath,
    };
  }
}

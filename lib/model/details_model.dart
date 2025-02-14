class MoviesResponse {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  List<Cast>? cast;
  List<String>? screenshots;

  MoviesResponse({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.cast,
    this.screenshots,
  });

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'] != null
        ? BelongsToCollection.fromJson(json['belongs_to_collection'])
        : null;
    budget = json['budget'];
    genres = (json['genres'] as List?)?.map((e) => Genres.fromJson(e)).toList();
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originCountry = (json['origin_country'] as List<dynamic>?)?.map((e) => e.toString()).toList();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    productionCompanies = (json['production_companies'] as List?)?.map((e) => ProductionCompanies.fromJson(e)).toList();
    productionCountries = (json['production_countries'] as List?)?.map((e) => ProductionCountries.fromJson(e)).toList();
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    spokenLanguages = (json['spoken_languages'] as List?)?.map((e) => SpokenLanguages.fromJson(e)).toList();
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];

    if (json['credits'] != null && json['credits']['cast'] != null) {
      cast = (json['credits']['cast'] as List?)?.map((e) => Cast.fromJson(e)).toList();
    }

    // التحقق من الصور داخل images
    if (json.containsKey('images')) {
      var imagesData = json['images'];
      print("Images Section Data: $imagesData"); // ✅ طباعة للتأكد من البيانات

      if (imagesData.containsKey('backdrops') && (imagesData['backdrops'] as List).isNotEmpty) {
        screenshots = (imagesData['backdrops'] as List)
            .map((e) => "https://image.tmdb.org/t/p/w500${e['file_path']}")
            .toList();
        print("Extracted Screenshots from backdrops: $screenshots");
      } else if (imagesData.containsKey('posters') && (imagesData['posters'] as List).isNotEmpty) {
        screenshots = (imagesData['posters'] as List)
            .map((e) => "https://image.tmdb.org/t/p/w500${e['file_path']}")
            .toList();
        print("Extracted Screenshots from posters: $screenshots");
      } else if (imagesData.containsKey('stills') && (imagesData['stills'] as List).isNotEmpty) {
        screenshots = (imagesData['stills'] as List)
            .map((e) => "https://image.tmdb.org/t/p/w500${e['file_path']}")
            .toList();
        print("Extracted Screenshots from stills: $screenshots");
      } else {
        print("No screenshots available in images['backdrops'], images['posters'], or images['stills']!");
        screenshots = [];
      }
    }
  }
}


class Cast {
  int? id;
  String? name;
  String? profilePath;
  String? character;

  Cast({this.id, this.name, this.profilePath, this.character});

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePath = json['profile_path'];
    character = json['character'];
  }
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }
}

import 'package:hive_flutter/adapters.dart';

// A part file is defined here which includes the
// generated code for reading and writing data to the database.
part 'popular_movie_hive.g.dart';

// A [typeId] has to be assigned to the class.
//
// An [adapterName] has to be assigned to the class
// and it has to be registered before the calling the [runApp].
@HiveType(typeId: 0, adapterName: 'PopularMovieAdapter')
class PopularMovieHive extends HiveObject {
  PopularMovieHive({this.title, this.year});

  // An [index] value has to be assigned for each field.
  @HiveField(0)
  String? title;

  // An [index] value has to be assigned for each field.
  @HiveField(1)
  String? year;
}
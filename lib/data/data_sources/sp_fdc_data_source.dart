
import 'package:logging/logging.dart';

class SpFdcDataSource {
  final log = Logger('SPBackendDataSource');

 // Future<List<SpFdcFoodDTO>> fetchSearchWordResults(String searchString) async {
   // try {
   //   log.fine('Fetching Supabase FDC results');
      //final supaBaseClient = locator<SupabaseClient>();
    //  final queryDescriptionColumn = SPConst.getFdcFoodDescriptionColumnName(
     //     SupportedLanguage.fromCode(Platform.localeName));

      //final response = await supaBaseClient
       //   .from(SPConst.fdcFoodTableName)
       //   .select<List<Map<String, dynamic>>>(
       //       '''fdc_id, $queryDescriptionColumn, fdc_portions ( measure_unit_id, amount, gram_weight ), fdc_nutrients ( nutrient_id, amount )''')
        //  .textSearch(queryDescriptionColumn, searchString,
        //      type: TextSearchType.websearch)
        //  .limit(SPConst.maxNumberOfItems);

     // final fdcFoodItems =
       //   response.map((fdcFood) => SpFdcFoodDTO.fromJson(fdcFood)).toList();

     // log.fine('Successful response from Supabase');
     // return fdcFoodItems;
  //  } catch (exception, stacktrace) {
  //    log.severe('Exception while getting FDC word search $exception');
   //   Sentry.captureException(exception, stackTrace: stacktrace);
  //    return Future.error(exception);
 //   }
 // }
}

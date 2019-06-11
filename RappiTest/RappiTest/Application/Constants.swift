import Foundation
import AVFoundation
import UIKit


public enum environmentType {
    case vendedor, client
}

struct Constants {
    
    
    struct DeviceToken {
        static let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    struct Catalogs {
        static let dataCatalogs = [CatalogsType.topMovie, CatalogsType.topTv, CatalogsType.popularMovie, CatalogsType.popularTv, CatalogsType.upCommingMovie]
        static let dataGenders = [TypeItem.movie, TypeItem.serie]
    }
    
    struct UrlServices {
        static let api_Key_tmdb = "d21684866ab7c4cdf0891ef667519e53"
        static let BaseUrl = "https://api.themoviedb.org/3"
        static let BasePathImage = "http://image.tmdb.org/t/p/w500"
        static let GetPopularTv = UrlServices.BaseUrl + WSMethods.Tv + WSMethods.Popular + ParamsWS.CategorieParams
        static let GetTopRatedTv = UrlServices.BaseUrl + WSMethods.Tv + WSMethods.TopRated + ParamsWS.CategorieParams
        
        static let GetPopularMovie = UrlServices.BaseUrl + WSMethods.Movie + WSMethods.Popular + ParamsWS.CategorieParams
        static let GetTopRatedMovie = UrlServices.BaseUrl + WSMethods.Movie + WSMethods.TopRated + ParamsWS.CategorieParams
        static let GetUpcomingMovie = UrlServices.BaseUrl + WSMethods.Movie + WSMethods.Upcoming + ParamsWS.CategorieParams
        static let GetConfigImage = UrlServices.BaseUrl + WSMethods.ConfigImage + ParamsWS.ApiKey
        
        // Get Gener Movie
        static let GetGenerMovie = UrlServices.BaseUrl + WSMethods.Gener + WSMethods.Movie + WSMethods.List + ParamsWS.Params
        
        // Get Gener Serie
        static let GetGenerSerie = UrlServices.BaseUrl + WSMethods.Gener + WSMethods.Tv + WSMethods.List + ParamsWS.Params
        
        static let Content_Type = "application/json; charset=utf-8"
        
        static let BasePathMovie = UrlServices.BaseUrl + WSMethods.Movie
        static let BasePathTV = UrlServices.BaseUrl + WSMethods.Tv
        static let BasePathVideo = WSMethods.Video +  ParamsWS.ApiKey + ParamsWS.LanguageVideo
        static let BasePathSimilar  = WSMethods.SimilarMovie +  ParamsWS.ApiKey + ParamsWS.Language + ParamsWS.Page + "1"
    }
    
    struct ParamsWS {
        static let ApiKey = "?api_key=\(UrlServices.api_Key_tmdb)"
        static let Language = "&language=es-MX"
        static let LanguageVideo = "&language=en-US"
        static let Page = "&page="
        static let Query = "&query="
        static let CategorieParams = ParamsWS.ApiKey + ParamsWS.Language + ParamsWS.Page
        static let Params = ParamsWS.ApiKey + ParamsWS.Language
        static let MultiSearchParams = ParamsWS.CategorieParams + ParamsWS.Query
    }
    
    struct WSMethods {
        static let Tv = "/tv"
        static let Movie = "/movie"
        static let MultiSearch = "/search/multi"
        static let SimilarMovie = "/similar"
        static let Video = "/videos"
        static let Popular = "/popular"
        static let TopRated = "/top_rated"
        static let Upcoming = "/upcoming"
        static let ConfigImage = "/configuration"
        static let Gener = "/genre"
        static let List = "/list"
    }
    
    struct CategoriesPaths {
        static let CategoriesData : [Categories: String] = [Categories.Popular: UrlServices.GetPopularMovie, Categories.TopRated: UrlServices.GetTopRatedMovie, Categories.Upcoming: UrlServices.GetUpcomingMovie]
        
        static let CategoriesRealmPaths : [Categories: String] = [Categories.Popular: KeysRealmObject.RealmPopularMovies, Categories.TopRated: KeysRealmObject.RealmTopRatedMovies, Categories.Upcoming: KeysRealmObject.RealmUpcomingMovies]
    }
    
    
    struct FormatsDate {
        static let DateResponseToken = "yyyy-MM-dd HH:mm:ss"
    }
    
    struct devicesWidth {
        static let widthDeviceThird = UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3)
        static let widthDevice = UIScreen.main.bounds.width
        static let widthToAlert = UIScreen.main.bounds.width - 15
        static let widthDeviceInsets = UIScreen.main.bounds.width - 30
        static let widthDeviceMiddle = (UIScreen.main.bounds.width/2)
        static let heightDevice = UIScreen.main.bounds.height
    }
    
    struct GlobalMessage {
        struct Error {
            static let errorMessage = "Servicio no disponible"
            static let errorDetailProduct = "Producto no encontrado, intenta con otro"
        }
        
        struct Connection {
            static let internetConnection = "Se requiere conexión a Internet"
        }
        
    }
    
    struct constantsData {
        static let insetsHorizontal = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        static let insetsVertical = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        static let insetsVerticalGeneric = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    struct devicesSize {
        static let widthDeviceThird = UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3)
        static let widthDevice = UIScreen.main.bounds.width
        static let widthDeviceInsets = UIScreen.main.bounds.width - 30
        static let widthDeviceMiddle = (UIScreen.main.bounds.width/2)
        static let heightDevice = UIScreen.main.bounds.height
        static let widthTestSize = (UIScreen.main.bounds.width / 4)
    }
    
    
    struct KeysRealmObject {
        static let CacheManagerRealm = "CacheManager"
        static let RealmConfigImages = "ConfigImages"
        static let RealmPopularMovies = "PopularMovies"
        static let RealmTopRatedMovies = "TopRatedMovies"
        static let RealmPopularTv = "PopularTV"
        static let RealmTopRatedTv = "TopRatedTV"
        static let RealmUpcomingMovies = "UpcomingMovies"
        static let RealmMovieModel = "MoviesModel"
        // Catalog Downloads
        static let RealmCatalogDownload = "RealmCatalogDownload"
        // Genders
        static let RealmGendersMovie = "RealmGendersMovie"
        static let RealmGendersSerie = "RealmGendersSerie"
    }
    
    
}

// MARK: Enums App
enum ManagerResult {
    case success
    case failure(message:String)
}

enum TypeDateString: String {
    case hour
    case date
}

public enum ServicesManagerResult {
    case success
    case failure(message : String)
}

enum Categories: String {
    case Popular
    case TopRated
    case Upcoming
}

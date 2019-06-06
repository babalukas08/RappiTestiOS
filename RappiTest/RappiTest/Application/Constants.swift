import Foundation
import AVFoundation
import UIKit


public enum environmentType {
    case vendedor, client
}

struct Constants {
    
    struct LoginStrings {
        static let loginTitle = "Iniciar sesión"
        static let loginDescription = "¿Eres nuevo con nosotros?"
        static let loginActionLabel = "Crea una cuenta"
        static let loginActionButton = "Iniciar sesión"
        static let loginFBButton = "Iniciar sesión usando Facebook"
        //register
        static let registerTitle = "Crear cuenta"
        static let registerDescription = "¿Ya una tienes cuenta?"
        static let registerActionLabel = "Inicia sesión"
        static let registerActionButton = "Crear cuenta"
        static let registerFBButton = "Crear cuenta usando Facebook"
    }
    
    struct DeviceToken {
        static let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    struct PayPalKeys {
        static let urlSheme = "com.alphasoluciones.go.payments"
        //        static let tokenPath = "http://172.16.0.60:5000/tk"//"https://braintree-sample-merchant.herokuapp.com/client_token"
        //        static let postPurchase = "http://172.16.0.60:5000/checkout"
        static let tokenPath = "http://alphasoluciones.net:9020/tk"//"https://braintree-sample-merchant.herokuapp.com/client_token"
        static let postPurchase = "http://alphasoluciones.net:9020/checkout"
        static let clientTokenSample = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIyMWFkM2E2MTg3OThiMzE4MWIxYzQ3MmQ0MTUwYmE4ODk1NTY1MjFiODA2NjI1M2ZlNjc0YTU1ZTdmN2U2MWI1fGNyZWF0ZWRfYXQ9MjAxOS0wNS0wOFQxNToxMzowMS40MTczMjAyMTIrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0="
    }
    
    struct ApisKeys {
        
    }
    
    struct UrlServices {
        
        #if VENDEDORVERSION
        static let urlBase = "http://10.253.15.5:8080/eph_loftdigital"
        static let environment: environmentType = .vendedor
        #elseif IPADALPHAVERSION
        static let urlBase = "https://appd.elpalaciodehierro.com:9443/eph_loftdigital"
        static let environment: environmentType = .vendedor
        #else
        static let urlBase = "https://appd.elpalaciodehierro.com:9443/eph_loftdigital"
        static let environment: environmentType = .client
        #endif
        
        
        static let Content_TypeToken = "application/x-www-form-urlencoded"
        static let Content_Type = "application/json; charset=utf-8"
        static let Authorization = "OAuth %@"
        static let plataform = "iOS"
        static let GENEXUS_AGENT = "SmartDevice Application"
        static let BodyToken = "client_id=e4322c795fed4e2dabdbd525e7a1decc&granttype=password&scope=FullControl&username=eph_loftdigital&password=3ph_n4v1d4d3s"
    }
    
    struct APIMethods {
        static let AccessToken = "/oauth/access_token"
        static let ProductInfo = "/rest/services/productInfo"
        static let AddList = "/rest/services/addList"
        static let SendEmail = "/rest/services/sendEmail"
        static let newBag = "/newBag"
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
            static let errorMessage = "Inténtalo en un momento."
            static let errorDetailProduct = "Producto no encontrado, intenta con otro"
            static let errorMessageEcomm = "Lo sentimos, los artículos escaneados no se pudieron agregar al carrito, por favor búscalos directamente en El Palacio de los Juguetes."
        }
        
        struct Connection {
            static let internetConnection = "Se requiere conexión a Internet"
        }
        
        struct WebServiceError {
            static let wsError = "Inténtalo en un momento."
            static let wsSendEmilOk = "E-mail enviado"
            static let wsSendEmilError = "Error al enviar E-mail"
            static let wsSendSMSOk = "Mensaje enviado"
            static let wsSendSMSError = "Error al enviar mensaje"
            static let wsServicioNo = "Servicio no disponible"
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
        // Current Token
        static let RealmAccessTokenModel = "RealmAccessTokenModel"
        // Current RealmCurrentProducts
        static let RealmCurrentStorageModels = "RealmCurrentStorageModels"
        // Current RealmDataStorage
        static let RealmCurrentStorage = "RealmCurrentStorage"
        // Current RealmCurrentProduct
        static let RealmCurrentProduct = "RealmCurrentProduct"
        
        //Current ModelStorage
        static let RealmCurrentModelStorage = "RealmCurrentModelStorage"

    }
    
    struct Samples {
        static let detailModel = DetailProductModel(imageUrl: "https://media.elpalaciodehierro.com/media/catalog/product/cache/1/image/1800x1800/9df78eab33525d08d6e5fb8d27136e95/3/6/36157882_palaciodehierro_sofacamakironrojo_liz_vista_1.jpg", price: "$ 27,490.00", titleProduct: "SILLÓN", descProduct: "Muebles Liz Sofá cama tapizado en tela rojo, puede convertirse en una cama Queen Size. Modelo: KIRON SC ROJO Material: Madera estructurada Herraje metálico Espuma Delcron Tela. Estilo: Contempor Alto: 78 Cm. Prof: 90 Cm. Ancho: 222 Cm. Tipo salas: Sillones Incluye: 2 Riñoneras decorativas en color beige. Descripción corta: Sillón", sku: "123456789", idLetterModel: "09")
        static let dataProducts = [Samples.detailModel,Samples.detailModel,Samples.detailModel,Samples.detailModel,Samples.detailModel,Samples.detailModel]
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

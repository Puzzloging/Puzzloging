//
//  temp.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/15.
//

import UIKit
import Moya

enum TotalAPI {
    case login(_ name: String)
    case imageUpload(_ color: GridColor, _ image: UIImage)
    case getPhoto
    case generateMosaic(_ colors: [GridColor], _ image: UIImage)
    case getMosaicImage
}

extension TotalAPI: TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.endpoint)!
    }
    
    var path: String {
        switch self {
        case .login(_):
            return APIConstants.login
        case .imageUpload(_,_):
            return APIConstants.imageUpload
        case .getPhoto:
            return APIConstants.getPhoto + User.myId
        case .generateMosaic(_,_):
            return APIConstants.generateMosaic
        case .getMosaicImage:
            return APIConstants.getMosaic + User.myId
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhoto, .getMosaicImage:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login(_):
            return Data(
                """
                {
                  "success" : true,
                  "data" : {
                    "id" : 1,
                    "name" : "ChangGyo"
                  },
                  "error" : null
                }
                """.utf8
            )
        case .imageUpload(_,_):
            return Data(
                """
                {
                  "success" : true,
                  "data": {
                    "imageId" : 1,
                    "imagePath" : "https://puzzlogging.s3.ap-northeast-2.amazonaws.com/1/trashImage/10ccfa35-5e7a-422f-a4ac-6eeccda3f0a3.jpg",
                    "color" : "Black"
                  },
                  "error" : null
                }
                """.utf8
            )
        case .getPhoto:
            return Data(
                """
                {
                  "success" : true,
                  "data": [
                    {
                      "imageId" : 1,
                      "imagePath" : "https://puzzlogging.s3.ap-northeast-2.amazonaws.com/1/trashImage/10ccfa35-5e7a-422f-a4ac-6eeccda3f0a3.jpg",
                      "color" : "Black"
                    }
                  ],
                  "error" : null
                }
                """.utf8
            )
        case .generateMosaic(_,_):
            return Data(
                """
                {
                    "imageId" : 1,
                    "imagePath" : "https://puzzlogging.s3.ap-northeast-2.amazonaws.com/1/trashImage/10ccfa35-5e7a-422f-a4ac-6eeccda3f0a3.jpg",
                    "color" : "Black"
                }
                """.utf8
                )
        case .getMosaicImage:
            return Data(
                """
                {
                    "imageId" : 1,
                    "imagePath" : "https://puzzlogging.s3.ap-northeast-2.amazonaws.com/1/trashImage/10ccfa35-5e7a-422f-a4ac-6eeccda3f0a3.jpg",
                    "color" : "Black"
                }
                """.utf8
                )
        }
    }
    //var parameter:
    
    var task: Moya.Task {
        switch self {
        case .login(var name):
            let param: [String : String] = [
                "name" : name
            ]
            guard let encodingData = try? JSONEncoder().encode(param) else { return .requestPlain}
            return .requestData(encodingData)
            
        case .imageUpload(let color, let images):

            let image = images.jpegData(compressionQuality: 1)!
            struct temp: Codable {
                let memberId: String
                let color: String
            }
            let param = temp(memberId: User.myId, color: color.rawValue)
            guard let request = try? JSONEncoder().encode(param) else { return .requestPlain }
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(request), name: "request", mimeType: "application/json")]
            formData.append(Moya.MultipartFormData(provider: .data(image), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg"))
            
            return .uploadMultipart(formData)
            
        case .getPhoto:
            return .requestPlain
            
        case .generateMosaic(let colors, let image):
            let imageData = image.jpegData(compressionQuality: 1)
            struct temp: Codable {
                let memberId: String
                let colors: [String]
            }
            let param = temp(memberId: User.myId, colors: colors.map{ $0.rawValue })
            guard let request = try? JSONEncoder().encode(param) else { return .requestPlain }
            print(String(data: request, encoding: .utf8))
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(request), name: "request", mimeType: "application/json")]
            formData.append(MultipartFormData(provider: .data(imageData!), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg"))
            return .uploadMultipart(formData)
            
        case .getMosaicImage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .imageUpload(_, _), .generateMosaic(_, _):
            return ["Content-Type" : "multipart/form-data"]
        default:
            return ["Content-Type" : "application/json"]
        }
       
    }
    
    static func returnType(of type: TotalAPI) -> Codable.Type {
        switch type {
        case .login(_):
            return CommonRes<LoginInfo>.self
        case .imageUpload(_,_):
            return CommonRes<Image>.self
        case .getPhoto:
            return CommonResWithArray<Image>.self
        case .generateMosaic(_,_):
            return CommonRes<MosaicImage>.self
        case .getMosaicImage:
            return CommonResWithArray<MosaicImage>.self
        }
    }
}

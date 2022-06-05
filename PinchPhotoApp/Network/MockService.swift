//
//  MockService.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
class MockService:ServiceProtocol{
  var albums: AlbumResponse?
  var photos: PhotoResponse?
  var didCallGetPhotos: Bool = false
  var didCallGetAlbums: Bool = false
  
  func getAlbums() -> Observable<AlbumResponse> {
    didCallGetAlbums = true
    albums = AlbumResponse()
    return Observable.create { observer -> Disposable in
      observer.onNext(self.albums!)
        return Disposables.create()
    }
  }
  
  func getPhotos(_ id: Int,_ page: Int) -> Observable<PhotoResponse> {
    didCallGetPhotos = true
    photos = PhotoResponse()
    return Observable.create { observer -> Disposable in
      observer.onNext(self.photos!)
        return Disposables.create()
    }
  }
  
  
}

//
//import Foundation
//
//final class MockReferralsNetworkingService: ReferralsNetworkInterface {
//    var referrals: [CustomerReferral] = [CustomerReferral]()
//
//    var didCallGetAllCustomerReferrals: Bool = false
//    var didCallGetAllReferralsWithStatus: Bool = false
//    var didCallGetCustomerReferralSummary: Bool = false
//    var didCallRecordNewReferral: Bool = false
//    var didCallRedeemReferralReward: Bool = false
//
//    var redemptionClosure: ((Result<[RedeemReferralReward], Error>) -> ())!
//    var referralSummaryClosure: ((Result<CustomerReferralSummary, Error>) -> ())!
//    var allReferralsClosure: ((Result<[CustomerReferral], Error>) -> ())!
//
//    func getAllCustomerReferrals(completion: @escaping (Result<[CustomerReferral], Error>) -> Void) {
//        didCallGetAllCustomerReferrals = true
//        allReferralsClosure = completion
//    }
//
//    func getAllCustomerReferralsWithStatus(status: ReferralStatus, completion: @escaping (Result<[CustomerReferral], Error>) -> ()) {
//        didCallGetAllReferralsWithStatus = true
//        completion(.success(referrals))
//    }
//
//    func getCustomerReferralSummary(completion: @escaping (Result<CustomerReferralSummary, Error>) -> ()) {
//        didCallGetCustomerReferralSummary = true
//        referralSummaryClosure = completion
//    }
//
//    func recordNewReferral(referralCode: String, completion: @escaping (Result<BaseApiResponse, Error>) -> ()) {
//        didCallRecordNewReferral = true
//        completion(.success(BaseApiResponse()))
//    }
//
//    func redeemReferralReward(referralId: String, completion: @escaping (Result<[RedeemReferralReward], Error>) -> ()) {
//        didCallRedeemReferralReward = true
//        redemptionClosure = completion
//    }
//
//    //Closures fo manilupating the state (success or failure) of the request
//    //Get All Referrals
//    func getAllReferralsFailure() {
//        allReferralsClosure(.failure(AppError.endpointError(message: errorMessages.networkDefault)))
//    }
//
//    func getAllReferralsSuccess() {
//        allReferralsClosure(.success(referrals))
//    }
//
//    //Referral Summary
//    func getAllReferralSummaryFailure() {
//        referralSummaryClosure(.failure(AppError.endpointError(message: errorMessages.networkDefault)))
//    }
//
//    func getAllReferralSummarySuccess() {
//        referralSummaryClosure(.success(CustomerReferralSummary()))
//    }
//
//    //Redeem Referral Reward
//    func redeemReferralRewardFailure() {
//        redemptionClosure(.failure(AppError.endpointError(message: errorMessages.networkDefault)))
//    }
//
//    func redeemReferralRewardSuccess() {
//        redemptionClosure(.success([RedeemReferralReward]()))
//    }
//}

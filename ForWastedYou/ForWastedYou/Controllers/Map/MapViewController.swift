//
//  MapViewController.swift
//  ForWastedYou
//
//  Created by 石澤大輔 on 2021/12/12.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    lazy var mapView: MKMapView = {
            let mapView = MKMapView(frame: view.frame)
            return mapView
        }()
    
    // 測位精度
    let locationAccuracy: [Double] = [
        kCLLocationAccuracyBestForNavigation,
        kCLLocationAccuracyBest,
        kCLLocationAccuracyNearestTenMeters,
        kCLLocationAccuracyHundredMeters,
        kCLLocationAccuracyKilometer,
        kCLLocationAccuracyThreeKilometers
    ]
    //座標の配列
// 直線を引く座標を作成.
        let coordinate_1 = CLLocationCoordinate2D(latitude: 37.301741, longitude: -122.050333)

        let coordinate_2 = CLLocationCoordinate2D(latitude: 37.351951, longitude: -122.020314)

        let coordinate_3 = CLLocationCoordinate2D(latitude: 37.301741, longitude: -122.020314)

        let coordinate_4 = CLLocationCoordinate2D(latitude: 37.351951, longitude: -122.050333)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(mapView)
        
        // locationManager初期化
        locationManager = CLLocationManager()
        
        // ユーザーの使用許可を確認
        locationManager.requestWhenInUseAuthorization()
        
        // 座標を配列に格納.
        var coordinates_1 = [coordinate_1, coordinate_2]

        var coordinates_2 = [coordinate_3, coordinate_4]
        
        // polyline作成.
        let myPolyLine_1: MKPolyline = MKPolyline(coordinates: &coordinates_1, count: coordinates_1.count)

        let myPolyLine_2: MKPolyline = MKPolyline(coordinates: &coordinates_2, count: coordinates_2.count)
        
        // 使用許可に対するステータス
        let status = CLLocationManager.authorizationStatus()
 
        if status == .authorizedWhenInUse {
 
            // delegateを設定
            locationManager.delegate = self
 
            // 測位精度の設定
            locationManager.desiredAccuracy = locationAccuracy[1]
            
            // アップデートする距離半径(m)
            locationManager.distanceFilter = 10
 
            // 位置情報の取得を開始
            locationManager.startUpdatingLocation()

        }
    }
                
    func locationManager(_ manager: CLLocationManager,
                didUpdateLocations locations: [CLLocation]) {
        // 最初のデータ
        let location = locations.first
 
        // 緯度
        let latitude = location?.coordinate.latitude
        // 経度
        let longitude = location?.coordinate.longitude
        
        if let coordinate = locations.last?.coordinate {
            // ピンをつける
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            mapView.addAnnotation(pin)
//            // mapViewにcircleを追加.
            // 現在地を拡大して表示する
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.region = region
            
            // 直線を引く座標を作成.
            let coordinate_1 = CLLocationCoordinate2D(latitude: 41.84210456, longitude: 140.76720180)

            let coordinate_2 = CLLocationCoordinate2D(latitude: 37.351951, longitude: -122.020314)

            let coordinate_3 = CLLocationCoordinate2D(latitude: 37.301741, longitude: -122.020314)

            let coordinate_4 = CLLocationCoordinate2D(latitude: 37.351951, longitude: -122.050333)
            
            // 座標を配列に格納.

            var coordinates_1 = [coordinate_1, coordinate_2]

            var coordinates_2 = [coordinate_3, coordinate_4]

            // polyline作成.

            let myPolyLine_1: MKPolyline = MKPolyline(coordinates: &coordinates_1, count: coordinates_1.count)

            let myPolyLine_2: MKPolyline = MKPolyline(coordinates: &coordinates_2, count: coordinates_2.count)

            // mapViewにcircleを追加.

            mapView.addOverlay(myPolyLine_1)

            mapView.addOverlay(myPolyLine_2)
        }
        
        // 測位の精度を指定(最高精度)
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 位置情報取得間隔を指定(100m移動したら、位置情報を通知)
        self.locationManager.distanceFilter = 100;
        
        // 自動で位置情報取得がOFFになるのを防ぐ
        print("latitude: \(latitude!)")
        print("longitude: \(longitude!)")
        
    }
    
    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }
    /*
    addOverlayした際に呼ばれるデリゲートメソッド.
    */

    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {

        // rendererを生成.
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)

        // 線の太さを指定.
        myPolyLineRendere.lineWidth = 500

        // 線の色を指定.
        myPolyLineRendere.strokeColor = UIColor.systemRed

        return myPolyLineRendere
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

//
// MapViewController.swift
// ForWastedYou
//
// Created by 石澤大輔 on 2021/12/12.
//
import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate {
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
    // 取得した緯度を保持するインスタンス
    var my_latitude: CLLocationDegrees!
    // 取得した経度を保持するインスタンス
    var my_longitude: CLLocationDegrees!
    //位置情報を記録するための配列
    var coordinates:[CLLocationCoordinate2D]=[]
    //  let df=DateFormatter()
    //
    //  var coordinate_lines:[[CLLocationCoordinate2D]]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mapを表示するviewcontrollerの設定
        mapView.delegate = self
        view.addSubview(mapView)
        // locationManager初期化
        locationManager = CLLocationManager()
        // ユーザーの使用許可を確認
        locationManager.requestWhenInUseAuthorization()
        //for文を作る。100m更新されたら配列を今の現在地に入れ替えて描画する
        //    let coordinate_2 = CLLocationCoordinate2D(latitude: 37.351951, longitude: 140.78720180)
        //
        //    let coordinate_3 = CLLocationCoordinate2D(latitude: 38.301741, longitude: 140.76720180)
        //
        //    let coordinate_4 = CLLocationCoordinate2D(latitude: 37.351951, longitude: 140.76720180)
        //
        //    // 座標を配列に格納.
        //    var coordinates_1 = [coordinate_1, coordinate_2]
        //    var coordinates_2 = [coordinate_3, coordinate_4]
        //
        //    // polyline作成.
        //    let myPolyLine_1: MKPolyline = MKPolyline(coordinates: &coordinates_1, count: coordinates_1.count)
        //
        //    let myPolyLine_2: MKPolyline = MKPolyline(coordinates: &coordinates_2, count: coordinates_2.count)
        //
        //    // mapViewにcircleを追加.
        //    mapView.addOverlay(myPolyLine_1)
        //    mapView.addOverlay(myPolyLine_2)
        // 使用許可に対するステータス
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            // delegateを設定
            locationManager.delegate = self
            // 測位精度の設定
            locationManager.desiredAccuracy = locationAccuracy[1]
            // アップデートする距離半径(m)
            locationManager.distanceFilter = 100
            // 位置情報の取得を開始
            locationManager.startUpdatingLocation()
            my_latitude = locationManager.location?.coordinate.latitude
            my_longitude = locationManager.location?.coordinate.longitude
            coordinates.append(CLLocationCoordinate2D(latitude: my_latitude, longitude: my_longitude))
        }
    }
    //distanceFilterの値を超えたときに呼び出される
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // 最初のデータ
        let location = locations.first
        // 緯度
        let latitude = location?.coordinate.latitude
        // 経度
        let longitude = location?.coordinate.longitude
        //更新データ
        guard let newLocation = locations.last,
              //有効なデータか判別
              CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                  print("無効なデータ")
                  return
              }
        //瞬間速度m/s
        let speed = newLocation.speed
        //現在と１つ前の地点の距離
        let distance = location!.distance(from: newLocation)
        print("新しい緯度と経度")
        print(newLocation)
        //新しい情報が記録された時間を格納
        //    let location_time = newLocation.timestamp
        //以前の位置情報を格納
        let old_coordinates=coordinates.last
        //位置情報を記録
        coordinates.append(CLLocationCoordinate2D(latitude:latitude!, longitude:longitude!))
        //現在の位置情報を格納
        let new_coordinates=coordinates.last
        //    coordinate_lines.append([coordinates[coordinates.count-1],coordinates.last])
        //    let speed = old_coordinates.sp
        if let coordinate = locations.last?.coordinate {
            // ピンをつける
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            //      df.dateFormat = location_time
            pin.title = String(distance)
            pin.subtitle = String(speed)
            mapView.addAnnotation(pin)
            // mapViewにcircleを追加.
            // 現在地を拡大して表示する
            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            //MKCoordinateRegion(緯度経度、縮尺)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.region = region
        }
        //描画
        let coordinate_line = [old_coordinates!,new_coordinates!]
        let myPolyLine: MKPolyline = MKPolyline(coordinates: coordinate_line, count: coordinate_line.count)
        mapView.addOverlay(myPolyLine)
        //描画終わり
        // 測位の精度を指定(最高精度)
        //    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //    // 位置情報取得間隔を指定(100m移動したら、位置情報を通知)
        //    self.locationManager.distanceFilter = 100;
        //
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
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // rendererを生成.
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        // 線の太さを指定.
        myPolyLineRendere.lineWidth = 5
        // 線の色を指定.
        myPolyLineRendere.strokeColor = .systemPink
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

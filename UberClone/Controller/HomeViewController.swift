//
//  HomeViewController.swift
//  UberClone
//
//  Created by Puspank Kumar on 02/03/20.
//  Copyright © 2020 Puspank Kumar. All rights reserved.
//

import UIKit
import Firebase
import MapKit

private let reuseIdentifier = "LocationTableViewCell"

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    private final let locationInputViewHeight: CGFloat = 200


}

// MARK: View Life Cycle
extension HomeViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
           checkIfUserIsLoggedIn()
            enableLocationService()
         //   signOut()
        }
}

extension HomeViewController {
    func configureUI() {
        configureMapView()
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(height: 50, width: view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        inputActivationView.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.inputActivationView.alpha = 1
        }
        
        configureTableView()

        // Callback from inputActivationView
        inputActivationView.presentLocationInputView = {
            self.inputActivationView.alpha = 0
            self.configureLocationInputView()
        }
        
        locationInputView.dismissLocationInputView = {
            UIView.animate(withDuration: 0.3, animations: {
                self.locationInputView.alpha = 0
                self.tableView.frame.origin.y = self.view.frame.height
                self.locationInputView.removeFromSuperview()
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.inputActivationView.alpha = 1
                }
            }
        }
        
        configureTableView()

    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height,
                                 width: view.frame.width, height: height)
        
        view.addSubview(tableView)
        
    }
    
    func configureLocationInputView() {
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            })
        }
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}


// MARK:- Service Handler
extension HomeViewController {
    
    /// Checking user ir logged in or not
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                self.present(nav, animated: true)
            }
            
        } else {
            configureUI()
        }
    }
    
    // Logged in user log out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch  {
            print("error signing out")
        }
    }
}


private extension HomeViewController {
    func enableLocationService() {
        
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

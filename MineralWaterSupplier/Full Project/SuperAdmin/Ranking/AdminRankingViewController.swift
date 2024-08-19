//
//  AdminRankingViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

class AdminRankingViewController: UIViewController {
    @IBOutlet weak var rdbtnPacking: UIButton!
    @IBOutlet weak var rdbtnQuality: UIButton!
    @IBOutlet weak var rdbtndelivery: UIButton!
    var Rankinglist = [Ranking](){
        didSet{
            DispatchQueue.main.async {
                self.tblranking.reloadData()
            }
        }
    }
    
    @IBAction func rdbtnPackingClick(_ sender: Any) {
        rdbtnPacking.isSelected = true
        rdbtnQuality.isSelected = false
        rdbtndelivery.isSelected = false
        packingAction()
      
    }
    
    @IBAction func rdbtnQualityClick(_ sender: Any) {
        rdbtnPacking.isSelected = false
        rdbtnQuality.isSelected = true
        rdbtndelivery.isSelected = false
        qualityAction()
        
    }
    @IBAction func rdbtndeliveryClick(_ sender: Any) {
        rdbtnPacking.isSelected = false
        rdbtnQuality.isSelected = false
        rdbtndelivery.isSelected = true
        TimeAction()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        tblranking.dataSource = self
        tblranking.delegate = self
        
    }
    @objc func packingAction() {
        sno = 0
        sno = sno + 1
        let endpoint = "User/PackingRanking"
        
        let params: [String: Any] = ["cid": 0]
        NetworkManager.shared.request(endpoint, decoder: [Ranking].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.Rankinglist = data
                self.tblranking.reloadData()
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    @objc func qualityAction() {
        sno = 0
        sno = sno + 1
        let endpoint = "User/QualityRanking"
        
        let params: [String: Any] = ["cid": 0]
        NetworkManager.shared.request(endpoint, decoder: [Ranking].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.Rankinglist = data
                self.tblranking.reloadData()
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    @objc func TimeAction() {
        sno = 0
        sno = sno + 1
        let endpoint = "User/TimeRanking"
        
        let params: [String: Any] = ["cid": 0]
        NetworkManager.shared.request(endpoint, decoder: [Ranking].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.Rankinglist = data
                self.tblranking.reloadData()
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SuperAdminHomeViewController") as! SuperAdminHomeViewController
        //     self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
        let backgroundimageview = UIImageView()
        func setBackground() {
            view.addSubview(backgroundimageview)
            backgroundimageview.translatesAutoresizingMaskIntoConstraints = false
            backgroundimageview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            backgroundimageview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            backgroundimageview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            backgroundimageview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            backgroundimageview.image = UIImage(named: "super")
            view.sendSubviewToBack(backgroundimageview)
    
        }
   
    

    @IBOutlet weak var tblranking: UITableView!
//var names = ["Nestle","Aquafina","Aquarion","Muree Sparklets","Sprinkles"]
//var sno = [1,2,3,4,5]
    var sno = 1
}

extension AdminRankingViewController :UITableViewDataSource, UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rankinglist.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblranking.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankingTableViewCell
        let rate = Rankinglist[indexPath.row]
        cell.lbname.text = rate.name
        cell.lbno.text = "\(sno)"
        cell.total.text = "\(rate.total ?? 0)"
        
        return cell;
    }
    
    
}

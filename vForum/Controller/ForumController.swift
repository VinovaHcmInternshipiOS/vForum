import Foundation
import UIKit
import SnapKit

class ForumController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var GroupItemList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GroupItemList.register(UINib(nibName: "ForumItemView", bundle: nil), forCellWithReuseIdentifier: "ForumItem")
        GroupItemList.delegate = self
        GroupItemList.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ForumItem", for: indexPath) as! ForumItem
        item.View.layer.cornerRadius = 25
        item.View.layer.shadowRadius = 7
        item.View.layer.shadowOpacity = 0.5
        return item
    }
}

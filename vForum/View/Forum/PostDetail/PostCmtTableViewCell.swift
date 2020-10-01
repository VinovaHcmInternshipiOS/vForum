import UIKit
import SnapKit
class PostCmtTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var cmtLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpContraints()
    }

    private func setUpContraints(){
        
        userLbl.snp.makeConstraints{(make) -> Void in
            make.top.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
        
        cmtLbl.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(10)
            make.top.equalTo(userLbl.snp_bottom).offset(5)
            make.bottom.trailing.equalTo(-10)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

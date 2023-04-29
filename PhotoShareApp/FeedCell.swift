import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

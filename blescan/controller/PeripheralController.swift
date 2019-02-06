

import UIKit

class PeripheralController: UIViewController {
 
    
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var lblMacAddress: UILabel!
    @IBOutlet weak var lblAdv: UILabel!
    var peripheral: Peripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDeviceName.text=peripheral.deviceName
        lblMacAddress.text=peripheral.macAddress
        lblAdv.text=peripheral.advertisementData.description
        // Do any additional setup after loading the view.
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

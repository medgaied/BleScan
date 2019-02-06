import UIKit
import CoreBluetooth

class HomeController: UIViewController , UITableViewDelegate,UITableViewDataSource , CBCentralManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var manager: CBCentralManager!
    let scanningDelay = 1.0
    var peripherals :[Peripheral] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         manager = CBCentralManager(delegate: self, queue: nil)
        let cellNib = UINib(nibName:"ItemTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "identifier")
        self.tableView.dataSource=self
        self.tableView.delegate=self

    }
    // Check if the bluetooth is powered on
    // Start looking for devices
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Scanning for devices")
            manager.scanForPeripherals(withServices: nil, options: nil)
        }  else {
            print("Bluetooth not available.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        if let name = peripheral.name{
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            peripherals.append(Peripheral.init(deviceName: name, macAddress: peripheral.identifier.uuidString, temp: RSSI.doubleValue, dateTime: formatter.string(from: date), advertisementData: advertisementData))
        }
        tableView.reloadData()
        //didReadPeripheral(peripheral, rssi: RSSI)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = peripherals[indexPath.row]
        let peripheralController=PeripheralController()
        peripheralController.peripheral = peripheral
        navigationController?.pushViewController(peripheralController, animated: true)
        
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
        peripheral.readRSSI()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier") as! ItemTableViewCell
        let peripheral = peripherals[indexPath.row]
        cell.lblDeviceName.text = peripheral.deviceName
        cell.lblAddressMac.text=peripheral.macAddress
        cell.lblTemp.text=String(peripheral.temp)
        cell.lblDateTime.text=peripheral.dateTime
        return cell;

    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}


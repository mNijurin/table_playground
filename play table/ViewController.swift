import UIKit

//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
class ViewController: UITableViewController {
//    @IBOutlet var tableView: UITableView!

    var texts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "do", style: .plain, target: self, action: #selector(doSome))
        
        navigationController?.navigationBar.isOpaque = true
        for i in 0...100 {
            texts.append("\(i)")
        }
    }

    @objc func doSome() {
        let text = texts[50]
        texts.remove(at: 50)
        texts.insert(text, at: 0)
        tableView.beginUpdates()
        tableView.moveRow(at: IndexPath(row: 50, section: 0), to: IndexPath(row: 0, section: 0))
        tableView.endUpdates()

        texts.remove(at: 0)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let someCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            return someCell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            let label = UILabel(frame: CGRect(x: 50, y: 0, width: 300, height: 40))
            label.textColor = .black
            label.tag = 13
            cell.textLabel?.addSubview(label)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("bind row: \(indexPath.row) \(Unmanaged.passUnretained(cell).toOpaque())")
        cell.textLabel?.text = texts[indexPath.row]

        let label = cell.contentView.viewWithTag(13) as? UILabel
        label?.text = "\(label?.text ?? "")1"
        print("willDisplay \(label?.text)")
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("unbind row: \(indexPath.row) \(Unmanaged.passUnretained(cell).toOpaque())")
        cell.textLabel?.text = nil

        let label = cell.contentView.viewWithTag(13) as? UILabel
        if let text = label?.text, text.count == 1 {
            label?.text = ""
        } else if let text = label?.text, text.count > 0 {
            var text = text
            text.remove(at: text.index(text.endIndex, offsetBy: -1))
            label?.text = text
        }
        print("endDisplay \(label?.text)")
    }

}


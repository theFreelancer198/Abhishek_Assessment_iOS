import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let viewModel = JsonViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()

        viewModel.fetchJsonData() // Fetch initial data
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
 
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.jsondataChanged = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        viewModel.errorOccurred = {
            DispatchQueue.main.async {
                if let errorMessage = self.viewModel.errorMessage {
                    self.showError(errorMessage)
                }
            }
        }

        viewModel.loadingStateChanged = {
            DispatchQueue.main.async {
                if self.viewModel.isLoading {
                    self.showLoadingIndicator()
                } else {
                    self.hideLoadingIndicator()
                }
            }
        }
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.startAnimating()
        tableView.backgroundView = loadingIndicator
    }

    private func hideLoadingIndicator() {
        tableView.backgroundView = nil
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jsonData.count
    }

    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }

        let data = viewModel.jsonData[indexPath.row]
        cell?.textLabel?.text = "\(data.id)"
        cell?.textLabel?.font = .boldSystemFont(ofSize: 15)
        cell?.detailTextLabel?.text = "\(data.title)"
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.font = .systemFont(ofSize: 15)
        return cell ?? UITableViewCell()
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = viewModel.jsonData[indexPath.row]

        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailViewController.dataDetails = selectedData

        self.navigationController?.pushViewController(detailViewController, animated: true)

       tableView.deselectRow(at: indexPath, animated: true)
        
    }

    // MARK: Pagination  - Disabled as provided api doesnot support pagination
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let frameHeight = scrollView.frame.size.height
//
//        if offsetY > contentHeight - frameHeight - 100 {
//            viewModel.fetchJsonData() // Trigger fetch when user is near the end
//        }
//    }
}

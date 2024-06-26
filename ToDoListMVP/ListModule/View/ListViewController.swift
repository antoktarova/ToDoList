import UIKit

protocol ListViewProtocol: AnyObject {
    func setNotes(notes: [NoteModel])
}

class ListViewController: UIViewController, ListViewProtocol {
    private var presenter: ListViewPresenterProtocol
    
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private let addButton = UIButton()
    
    private var notes: [NoteModel] = []
    
    init(presenter: ListViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        configureLayout()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchNotes()
    }
    
    private func configureUI() {
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        titleLabel.font = UIFont.systemFont(ofSize: 33)
        titleLabel.textColor = .darkGray
        titleLabel.text = "Мои заметки"
        
        tableView.layer.cornerRadius = 16
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36)
        ])
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -6),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40)
        ])
     
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -6)
        ])
    }
    
    @objc private func addButtonAction() {
        presenter.addNote()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func setNotes(notes: [NoteModel]) {
        self.notes = notes
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapOnTheNote(note: notes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell else { fatalError() }
        cell.configureUI(note: notes[indexPath.row])
        
        cell.deleteButonTapped = { [weak self] in
            guard let self else { return }
            presenter.deleteNote(note: notes[indexPath.row])
        }
        
        cell.updateButonTapped = { [weak self] in
            guard let self else { return }
            presenter.tapOnTheNote(note: notes[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(
            style: .normal,
            title: "Trash"
        ) { _, _, completionHandler in
            self.noteDeleteSwipe(indexPath: indexPath)
            completionHandler(true)
        }
        action1.backgroundColor = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1)
        action1.image = UIImage(named: "swipeForDelete")
        
        return UISwipeActionsConfiguration(actions: [action1])
    }
    
    func noteDeleteSwipe(indexPath: IndexPath) {
        presenter.deleteNote(note: notes[indexPath.row])
    }
}

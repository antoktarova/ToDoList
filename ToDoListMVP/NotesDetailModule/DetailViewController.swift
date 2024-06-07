import UIKit

protocol DetailViewProtocol: AnyObject {
    func setNote(note: String)
    func showNewNotes()
}

class DetailViewController: UIViewController, DetailViewProtocol {
    private var presenter: DetailViewPresenterProtocol
    
    private let commonStack = UIStackView()
    private let titleLabel = UILabel()
    private let field = UITextField()
    private let saveButton = UIButton()
    
    private var note: NoteModel? = nil
    
    init(presenter: DetailViewPresenterProtocol, note: NoteModel?) {
        self.presenter = presenter
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        
        configureLayout()
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.backgroundColor = .white
        titleLabel.layer.cornerRadius = 16
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.text = "экран редактирования"
        
        field.backgroundColor = .white
        field.layer.cornerRadius = 16
        
        if let note = note {
            field.text = note.title
            field.textColor = UIColor.black
        } else {
            field.text = "Что надо сделать?"
            field.textColor = UIColor.lightGray
        }
        
        saveButton.setTitle("сохранить", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.backgroundColor = .white
        saveButton.layer.cornerRadius = 16
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        commonStack.axis = .vertical
        commonStack.spacing = 16
        commonStack.addArrangedSubview(titleLabel)
        commonStack.addArrangedSubview(field)
        commonStack.addArrangedSubview(saveButton)
    }
    
    private func configureLayout() {
        view.addSubview(commonStack)
        commonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commonStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            commonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            commonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            commonStack.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setNote(note: String) {
        titleLabel.text = note
    }
    
    func showNewNotes() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonAction() {
        let note = NoteModel(
            id: self.note?.id ?? UUID(),
            title: field.text ?? ""
        )
        presenter.saveNote(note: note)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

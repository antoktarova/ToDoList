import UIKit

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
        
        configureCommonStack()
        presenter.showNote()
    }
    
    private func configureCommonStack() {
        view.addSubview(commonStack)
        
        commonStack.axis = .vertical
        commonStack.spacing = 16
        
        configureTitleLabel()
        configureField()
        configureSaveButton()
        commonStack.addArrangedSubview(titleLabel)
        commonStack.addArrangedSubview(field)
        commonStack.addArrangedSubview(saveButton)
        
        commonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commonStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            commonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            commonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            commonStack.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.backgroundColor = .white
        titleLabel.layer.cornerRadius = 16
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = .center
    }
    
    private func configureField() {
        field.backgroundColor = .white
        field.layer.cornerRadius = 16
        
        if let note = note {
            field.text = note.title
            field.textColor = UIColor.black
        } else {
            field.text = "Что надо сделать?"
            field.textColor = UIColor.lightGray
        }
        
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureSaveButton() {
        saveButton.setTitle("сохранить", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.backgroundColor = .white
        saveButton.layer.cornerRadius = 16
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    func setNote(note: String) {
        titleLabel.text = note
    }
    
    func showNewNotes() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonAction() {
        let note = NoteModel(
            id: self.note?.id ?? UUID(),
            title: self.field.text ?? ""
        )
        presenter.saveNote(note: note)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import Foundation
import UIKit

class NoteCell: UITableViewCell {
    
    private let stack = UIStackView()
    private let title = UILabel()
    private let deleteButton = UIButton()
    private let updateButton = UIButton()
    var deleteButonTapped: (()->())? = nil
    var updateButonTapped: (()->())? = nil
    
    func configureCell(note: NoteModel) {
        addSubview(stack)
        
        title.font = UIFont.systemFont(ofSize: 17)
        title.textColor = .gray
        title.text = note.title
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.addTarget(self, action:#selector(deletelButtonAction) , for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        updateButton.setImage(UIImage(systemName: "pencil.and.scribble"), for: .normal)
        updateButton.addTarget(self, action:#selector(updateButtonAction) , for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        stack.axis = .horizontal
        stack.spacing = 4
        stack.addArrangedSubview(deleteButton)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(updateButton)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func deletelButtonAction() {
        deleteButonTapped?()
    }
    
    @objc private func updateButtonAction() {
        updateButonTapped?()
    }
    
    override func prepareForReuse() {
        title.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

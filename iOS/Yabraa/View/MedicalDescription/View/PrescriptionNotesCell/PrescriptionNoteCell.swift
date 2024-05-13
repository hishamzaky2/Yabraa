//
//  PrescriptionNoteCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/11/2023.
//

import UIKit

class PrescriptionNoteCell: UITableViewCell {
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var noteTitel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(note: VisitNotes) {
        
        noteDate.text = "Date Created".localized + "  " + (note.createDTs ?? "").prefix(10)
        notes.text = note.description ?? ""
        noteTitel.text = note.title ?? ""
    }
    
}

//
//  DetailViewFuncs.swift
//  Listed
//
//  Created by Mbuso on 2021/09/28.
//

import Foundation
import UIKit

extension DetailView{
    
    func unwrapDescription(){
        if let recievedDescription = descriptionInput.text{
            if let recievedIndex = self.tappedIndex{
                GetDataInput().saveTaskDescription(recievedIndex, recievedDescription)
            }
        }
    }
}

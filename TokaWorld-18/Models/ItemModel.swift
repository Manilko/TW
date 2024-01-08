//
//  ItemModel.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 14.11.2023.
//

import UIKit


// MARK: - moc ItemModel
struct ItemModel{
    let title: String  // "_rd1li1"
    let icon: String  // "_rd1ld4"
    let discription: String  //"_rd1li1"
    var isFavorite   : Bool
    var isNew        : Bool
    var isPopular    : Bool
}
extension ItemModel{
    
    init(title: String, icon: String, discription: String) {
        
        self.title = title
        self.icon = icon
        self.discription = discription
        self.isFavorite = false
        self.isNew = false
        self.isPopular = false
    }
}
//
//struct MocDate{
//    
//    let collection: [ItemModel]
//    
//    
//}
//
//extension MocDate{
//    
//    init(){
//        let item = ItemModel(title: "Set Name", icon: "mocImage", discription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.")
//        self.collection = [item, item, item, item, item, item, item]
//    }
//    
//    init(complex: Bool = true){
//        let itemFavorite = ItemModel(title: "Set Name", icon: "mocImage", discription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.", isFavorite: true, isNew: false, isPopular: false)
//        let itemNew = ItemModel(title: "Set Name", icon: "mocImage", discription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.", isFavorite: false, isNew: true, isPopular: false)
//        let itemPopular = ItemModel(title: "Set Name", icon: "mocImage", discription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id adipiscing elit.", isFavorite: false, isNew: false, isPopular: true)
//        self.collection = [itemFavorite, itemFavorite, itemFavorite, itemFavorite, itemFavorite, itemFavorite, itemFavorite,itemNew,itemNew,itemNew,itemNew,itemPopular,itemPopular,itemPopular,itemPopular]
//    }
//}

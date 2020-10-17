//
//  CharactersView.swift
//  RickyAndMorty
//
//  Created by Dennis Vera on 10/17/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import SwiftUI

struct CharactersView: View {
  
  // MARK: - Body View
  
  var body: some View {
    Button(action: {
      NetworkManager.shared.fetchCharacters(page: nil) { result in
        switch result {
        case .success(let characters):
          characters.forEach {
            guard let name = $0.name else { return }
            print(name)
          }
        case .failure(let error):
          print(error.localizedDescription)
          
        }
      }
    }, label: {
      Text("Fetch")
    })
  }
}

struct CharactersView_Previews: PreviewProvider {
  
  // MARK: - Previews
  
  static var previews: some View {
    CharactersView()
  }
}

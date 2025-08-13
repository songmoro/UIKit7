//
//  PhotoViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class PhotoViewModel {
    struct Input {
        @MyObservable var searchButtonClicked: Void
        @MyObservable var fetchButtonClicked: Void
        @MyObservable var textFieldChanged: String?
    }
    
    struct Output {
        @MyObservable var photo: Photo?
        @MyObservable var photoList: [PhotoList]
    }
    
    var input: Input
    private(set) var output: Output
    
    init(input: Input = .init(searchButtonClicked: .init(value: ()), fetchButtonClicked: .init(value: ()), textFieldChanged: .init(value: "")), output: Output = .init(photo: .init(value: nil), photoList: .init(value: []))) {
        self.input = input
        self.input.searchButtonClicked = ()
        self.output = output
        
        bind()
    }
    
    private func bind() {
        input.$searchButtonClicked.bind { [weak self] in
            self?.getPhoto()
        }
        
        input.$textFieldChanged.bind { _ in
            print("textFieldChanged")
        }
        
        input.$fetchButtonClicked.bind { [weak self] _ in
            self?.fetchPhotoList()
        }
    }
    
    private func getPhoto() {
        guard let text = input.textFieldChanged, let photoId = Int(text), photoId >= 0 && photoId <= 100 else {
            print("0~100 사이의 숫자를 입력해주세요.")
            return
        }
        
        PhotoManager.shared.get(api: .id(id: photoId)) { [weak self] photo in
            self?.output.photo = photo
        }
    }
    
    private func fetchPhotoList() {
        PhotoManager.shared.get(api: .list(page: 1)) { [weak self] photoList in
            self?.output.photoList = photoList
        }
    }
}

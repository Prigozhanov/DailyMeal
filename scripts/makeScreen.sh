#!/bin/bash

name=$1

if [ "$name" != "" ]; then
    module_name=$(echo "$name")
    mkdir -p "$module_name"
    cd $module_name

echo "//
//  ${module_name}ViewController.swift
//

import UIKit

final class ${module_name}ViewController: UIViewController {

  private var viewModel: ${module_name}ViewModel

  init(viewModel: ${module_name}ViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  ${module_name}View
extension ${module_name}ViewController: ${module_name}View {

}

//MARK: -  Private
private extension ${module_name}ViewController {

}

" > ${module_name}ViewController.swift
echo "${module_name}ViewController was created"

echo "//
//  ${module_name}ViewModel.swift
//

import Foundation

//MARK: - View
protocol ${module_name}View: class {

}

//MARK: - ViewModel
protocol ${module_name}ViewModel {

var view: ${module_name}View? { get set }

}

//MARK: - Implementation
final class ${module_name}ViewModelImplementation: ${module_name}ViewModel {

  weak var view: ${module_name}View?

  init() {
  }

}

" > ${module_name}ViewModel.swift

echo "${module_name}ViewModel.swift was created"
    cd ..
    mkdir -p ../Source/Screens/$module_name
    mv $module_name ../Source/Screens/
    open ../Source/Screens/
else
    echo "[ERROR] Provide screen name"
    exit 0
fi

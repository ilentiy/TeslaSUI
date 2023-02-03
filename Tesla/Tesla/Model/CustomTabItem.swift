// CustomTabItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Иконка таб бара
struct TabItem: Identifiable, Equatable {
    /// Идентификатор
    var id = UUID()
    /// Имя картинки
    var imageName: String
}

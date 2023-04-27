//
//  CustomName.swift
//  OlimpicFind
//
//  Created by  Developer on 28.11.2022.
//
import Foundation

//MARK: - CLOUSURES
public typealias ClosureReturn<T> = (() -> T)
public typealias Closure<T>       = ((T) -> Void)
public typealias ClosureEmpty     = (() -> Void)
public typealias ClosureTwo<T, G> = ((T, G) -> Void)
public typealias ClosureAny       = ((Any?) -> Void)


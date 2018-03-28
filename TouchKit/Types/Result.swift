//
//  Result.swift
//  TouchKit
//
//  Created by Mario Canto on 3/27/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

/*

method signatures for transforms:

// synchronous, non failing
func transform<A,B>(value: A)->B

// async, non failing
func transform<A,B>(value: A, completion: (B->Void))

// synchronous, failable
func transform<A,B>(value: A)->Result<B>
func transform<A,B>(value: A) throws -> B

// async, failable
func transform<A,B>(value: A, completion: (Result<B>->Void))

*/

public enum Result<T> {
	case success(T)
	case failure(Error)
}

extension Result {
	// MARK: synchronous map, non failing
	public func map<U>(_ f: (T) -> U) -> Result<U> {
		switch self {
		case .success(let v):
			return .success(f(v))
		case .failure(let e):
			return .failure(e)
		}
	}
	// MARK: asynchronous map, non failing
	public func map<U>(_ f: @escaping (T, ((U) -> Void)) -> Void) -> ((Result<U>) -> Void) -> Void {
		return { g in
			switch self {
			case .success(let v):
				f(v) { transformed in
					g(.success(transformed))
				}
			case .failure(let e):
				g(.failure(e))
			}
		}
	}
}

extension Result {
	// MARK: sync flatMap or bind, failable
	public func flatMap<U>(_ f: (T) -> Result<U>) -> Result<U> {
		switch self {
		case .success(let v):
			return f(v)
		case .failure(let e):
			return .failure(e)
		}
	}
	
	// MARK: async flatMap or bind, failable
	public func flatMap<U>(_ f: @escaping (T, ((Result<U>) -> Void)) -> Void ) -> ((Result<U>) -> Void) -> Void {
		return { g in
			switch self {
			case .success(let v):
				f(v, g)
			case .failure(let e):
				g(.failure(e))
			}
		}
	}
}

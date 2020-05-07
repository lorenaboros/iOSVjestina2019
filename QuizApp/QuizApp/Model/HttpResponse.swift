//
//  ResultsSentResponse.swift
//  QuizApp
//
//  Created by Lorena Boroš on 16/05/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

enum HttpResponse: Int {
    case UNAUTORIZED = 401
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    case BAD_REQUEST = 400
    case OK = 200
}

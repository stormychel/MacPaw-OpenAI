//
//  EasyInputMessage.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.04.2025.
//

@_spi(Generated) import OpenAPIRuntime

/// A message input to the model with a role indicating instruction following
/// hierarchy. Instructions given with the `developer` or `system` role take
/// precedence over instructions given with the `user` role. Messages with the
/// `assistant` role are presumed to have been generated by the model in previous
/// interactions.
public struct EasyInputMessage: Codable, Hashable, Sendable {
    /// The role of the message input. One of `user`, `assistant`, `system`, or
    /// `developer`.
    @frozen public enum RolePayload: String, Codable, Hashable, Sendable, CaseIterable {
        case user = "user"
        case assistant = "assistant"
        case system = "system"
        case developer = "developer"
    }
    /// The role of the message input. One of `user`, `assistant`, `system`, or
    /// `developer`.
    public let role: EasyInputMessage.RolePayload
    /// Text, image, or audio input to the model, used to generate a response.
    /// Can also contain previous assistant responses.
    public enum ContentPayload: Codable, Hashable, Sendable {
        /// A text input to the model.
        case textInput(String)
        /// A list of one or many input items to the model, containing different content types.
        case inputItemContentList([InputContent])
        
        public init(from decoder: any Decoder) throws {
            var errors: [any Error] = []
            do {
                self = .textInput(try decoder.decodeFromSingleValueContainer())
                return
            } catch {
                errors.append(error)
            }
            do {
                self = .inputItemContentList(try decoder.decodeFromSingleValueContainer())
                return
            } catch {
                errors.append(error)
            }
            throw Swift.DecodingError.failedToDecodeOneOfSchema(
                type: Self.self,
                codingPath: decoder.codingPath,
                errors: errors
            )
        }
        public func encode(to encoder: any Encoder) throws {
            switch self {
            case let .textInput(value):
                try encoder.encodeToSingleValueContainer(value)
            case let .inputItemContentList(value):
                try encoder.encodeToSingleValueContainer(value)
            }
        }
    }
    /// Text, image, or audio input to the model, used to generate a response.
    /// Can also contain previous assistant responses.
    public let content: EasyInputMessage.ContentPayload
    /// The type of the message input. Always `message`.
    public let type: String?
    /// Creates a new `EasyInputMessage`.
    ///
    /// - Parameters:
    ///   - role: The role of the message input. One of `user`, `assistant`, `system`, or
    ///   - content: Text, image, or audio input to the model, used to generate a response.
    ///   - type: The type of the message input. Always `message`.
    public init(
        role: EasyInputMessage.RolePayload,
        content: EasyInputMessage.ContentPayload,
        type: String? = "message"
    ) {
        self.role = role
        self.content = content
        self.type = type
    }
    public enum CodingKeys: String, CodingKey {
        case role
        case content
        case type
    }
}

import Foundation
import SystemPackage
import BinaryParsing

class MetadataDB {
	private let data: Data
	let ranges: MetadataRanges

	init(at path: FilePath) throws {
		data = try File(at: path).readAll()
		ranges = try data.withParserSpan { try parseWinMD(&$0) }
	}

	func withTableSpan<T>(for kind: TableKind, rowIndex: Int, _ body: (inout ParserSpan) throws -> T) throws -> T {
		try data.withParserSpan { span in
			guard let range = ranges.tables[kind.rawValue] else {
				throw ParsingError()
			}
			try span.seek(toRange: range)
			try span.seek(toRelativeOffset: ranges.strides[kind.rawValue] * rowIndex)
			return try body(&span)
		}
	}
}

struct TypeDef {
	let metadata: MetadataDB
	let flags: TypeAttributes
	private let typeNameIndex: UInt32
	
	init(metadata: MetadataDB, rowIndex: Int) throws {
		self.metadata = metadata
		
		(flags, typeNameIndex) = try metadata.withTableSpan(for: .typeDef, rowIndex: rowIndex) { span in
			guard
				let flags = TypeAttributes(rawValue: try UInt32(parsingLittleEndian: &span))
			else {
				throw ParsingError()
			}

			let typeNameIndex = try UInt32(parsingLittleEndian: &span, byteCount: metadata.ranges.heapSizes!.stringSize)

			return (
				flags,
				typeNameIndex
			)
		}
	}
}

/// See ECMA-335 II.24.2.6, page 274
protocol CodedIndexTag {
	/// The number of bits used to encode the tag.
	static var bits: Int { get }

	// The tables that the index may point into.
	static var tables: [TableKind] { get }
}

enum TypeDefOrRef: Int, CodedIndexTag {
	static let bits = 2
	static let tables: [TableKind] = [.typeDef, .typeRef, .typeSpec]

	case typeDef, typeRef, typeSpec
}

enum HasConstant: Int, CodedIndexTag {
	static let bits = 2
	static let tables: [TableKind] = [.param, .field, .property]

	case field, param, property
}

enum HasCustomAttribute: Int, CodedIndexTag {
	static let bits = 5
	static let tables: [TableKind] = [
		.methodDef,
		.field,
		.typeRef,
		.typeDef,
		.param,
		.interfaceImpl,
		.memberRef,
		.module,
		.property,
		.event,
		.standAloneSig,
		.moduleRef,
		.typeSpec,
		.assembly,
		.assemblyRef,
		.file,
		.exportedType,
		.manifestResource,
		.genericParam,
		.genericParamConstraint,
		.methodSpec
	]

	case methodDef
	case field
	case typeRef
	case typeDef
	case param
	case interfaceImpl
	case memberRef
	case module
	case permission // this does not correspond to a table
	case property
	case event
	case standAloneSig
	case moduleRef
	case typeSpec
	case assembly
	case assemblyRef
	case file
	case exportedType
	case manifestResource
	case genericParam
	case genericParamConstraint
	case methodSpec
}

enum HasFieldMarshal: Int, CodedIndexTag {
	static let bits = 1
	static let tables: [TableKind] = [.field, .param]

	case field, param
}

enum HasDeclSecurity: Int, CodedIndexTag {
	static let bits = 2
	static let tables: [TableKind] = [.typeDef, .methodDef, .assembly]

	case typeDef, methodDef, assembly
}

enum MemberRefParent: Int, CodedIndexTag {
	static let bits = 3
	static let tables: [TableKind] = [.methodDef, .moduleRef, .typeDef, .typeRef, .typeSpec]

	case typeDef, typeRef, moduleRef, methodDef, typeSpec
}

enum HasSemantics: Int, CodedIndexTag {
	static let bits = 1
	static let tables: [TableKind] = [.event, .property]

	case event, property
}

enum MethodDefOrRef: Int, CodedIndexTag {
	static let bits = 1
	static let tables: [TableKind] = [.methodDef, .memberRef]

	case methodDef, memberRef
}

enum MemberForwarded: Int, CodedIndexTag {
	static let bits = 1
	static let tables: [TableKind] = [.field, .methodDef]

	case field, methodDef
}

enum Implementation: Int, CodedIndexTag {
	static let bits = 2
	static let tables: [TableKind] = [.file, .exportedType, .assemblyRef]

	case file, assemblyRef, exportedType
}

enum CustomAttributeType: Int, CodedIndexTag {
	static let bits = 3
	static let tables: [TableKind] = [.methodDef, .memberRef]

	// Not used
	// Not used
	case methodDef = 2, memberRef
	// Not used
}

enum ResolutionScope: Int, CodedIndexTag {
	static let bits = 2
	static let tables: [TableKind] = [.module, .moduleRef, .assemblyRef, .typeRef]

	case module, moduleRef, assemblyRef, typeRef
}

enum TypeOrMethodDef: Int, CodedIndexTag {
	static let bits = 1
	static let tables: [TableKind] = [.typeDef, .methodDef]

	case typeDef, methodDef
}

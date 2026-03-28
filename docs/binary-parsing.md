# Binary Parsing

Binary formats are not human readable, meaning we must parse them using code to
discover the information inside. We use a library called Swift Binary Parsing to
do this.

Resource: [Getting Started with
BinaryParsing](https://apple.github.io/swift-binary-parsing/documentation/binaryparsing/gettingstarted)

# CLI metadata format

Unless otherwise stated, the format is in little endian.

There are two ways metadata is stored in WinMD files:

1.  Tables (arrays of records) - ECMA-335 page 235

2.  Heaps - ECMA-335 page 298

# Tables

A table has a variable number of rows with a defined set of columns. The size of
each row is known, so we can multiply it by a row index to get the offset for
that row. This allows table rows to link to each other using indices for O(1)
lookups.

![Table structure diagram](./tables.svg)

There are two types of columns in table rows:

1.  Constant - A literal value or bitmask

2.  Index - An index to a row in the same or another table.

A bitmask constant stores multiple pieces of information in each byte, each of
which can be accessed using a bitmask that isolates the bits of interest.

There are two types of indices:

1.  Simple - an index into one, and only one, table
2.  Coded - an index into one of several tables. A few bits of the index value
    are reserved to define which table it targets.

# Heaps

Heaps are variable-length data regions where data is accessed via a byte offset.
The length or end of data in a heap is needed to know where to stop reading.

## String heap

The string heap contains null-terminated UTF-8 strings.

![Heap structure diagram](./heap.svg)

## Blob heap

The blob heap stores variable-length data in non-normalised, contiguous binary
objects called blobs. A blob stores its length in the first few bytes.

For example, method signatures describe the types of parameters of a method and
the type of its return value. They are stored in blobs because they can have any
number of parameters and cannot fit in a fixed-size table row.

The length prefix of blobs and integers within signatures are compressed using a
variable-length encoding; the first few bits signal the total byte length of the
number so that smaller numbers can be represented using fewer bytes. Compressed
integers are encoded in big-endian (i.e. with the most significant byte at the
smallest offset within the file) so that the length bits can be read first.

"use strict";
var read = require('pngjs').PNG.sync.read;
exports.decodeImpl = function(left) {
    return function(right) {
	return function(ab) {
	    try {
		return right(read(Buffer(ab)));
	    } catch (e) {
		return left(e);
	    };
	};
    };
};

exports.success = (statusCode, data) => {
    return {
        statusCode,
        body: JSON.stringify(data),
    };
};

exports.error = (statusCode, message) => {
    return {
        statusCode,
        body: JSON.stringify({ message }),
    };
};

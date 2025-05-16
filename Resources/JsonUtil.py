from robot.api.deco import keyword, library
from robot.api import logger
from jsonschema import validate
from jsonschema.exceptions  import ValidationError
from typing import Union, List
import json
import sys
sys.path.append('./')
@library
class JsonUtil:

    @keyword
    def validate_json_against_schema(self, json_object: Union[dict, List[dict]], schema_path: str):
        with open(schema_path) as f:
            schema = json.load(f)
        try:
            validate(instance=json_object, schema=schema)
            logger.info(f"Validation successful against schema {schema_path}")
            return True
        except ValidationError as e:
            logger.error(f"Schema validation failed with error; {e.message}")
            raise AssertionError(f"Schema validation failed: {e.message}")

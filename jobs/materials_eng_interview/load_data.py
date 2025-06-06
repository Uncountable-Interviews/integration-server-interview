import json
from decimal import Decimal

from uncountable.core import AuthDetailsApiKey, Client
from uncountable.types import (
    create_inputs_t,
    create_recipes_t,
    edit_recipe_inputs_t,
    entity_t,
    field_values_t,
    identifier_t,
    inputs_t,
    recipe_workflow_steps_t,
)

MATERIAL_FAMILY_ID = 1


def create_project(client: Client, project_name: str) -> entity_t.Entity:
    return client.create_entity(
        definition_id=1081,
        entity_type=entity_t.EntityType.PROJECT,
        field_values=[
            field_values_t.FieldRefNameValue(field_ref_name="name", value=project_name),
            field_values_t.FieldRefNameValue(
                field_ref_name="materialFamilyId", value=MATERIAL_FAMILY_ID
            ),
        ],
    ).entity


def load_data(client: Client, *, data: dict[str, dict]) -> None:
    inputs_lookup = {}

    project = create_project(
        client=client, project_name="Project 06/06/2025"
    )  # TODO update project_name

    for recipe_name, recipe_data in data.items():
        new_recipe_def = create_recipes_t.CreateRecipeDefinition(
            name=recipe_name, workflow_id=1
        )
        recipe = client.create_recipes(
            material_family_id=MATERIAL_FAMILY_ID,
            recipe_definitions=[new_recipe_def],
            project_id=project.id,
        ).recipes[0]

        inputs = recipe_data.get("inputs", {})
        recipe_input_edits: list[edit_recipe_inputs_t.RecipeInputEdit] = [
            edit_recipe_inputs_t.RecipeInputEditClearInputs()
        ]
        for input_name, input_val in inputs.items():
            if input_name not in inputs_lookup:
                input_to_create = create_inputs_t.InputToCreate(
                    name=input_name,
                    material_family_ids=[MATERIAL_FAMILY_ID],
                    quantity_type=inputs_t.IngredientQuantityType.NUMERIC,
                    type=inputs_t.IngredientType.INGREDIENT,
                )

                input_result = client.external_create_inputs(
                    inputs_to_create=[input_to_create]
                ).inputs[0]

                inputs_lookup[input_name] = input_result.input_id

            recipe_input_edits.append(
                edit_recipe_inputs_t.RecipeInputEditAddInput(
                    ingredient_key=identifier_t.IdentifierKeyId(
                        id=inputs_lookup[input_name]
                    ),
                    value_numeric=Decimal(input_val),
                )
            )

        client.edit_recipe_inputs(
            recipe_key=identifier_t.IdentifierKeyId(id=recipe.recipe_id),
            recipe_workflow_step_identifier=recipe_workflow_steps_t.RecipeWorkflowStepIdentifierDefault(),
            edits=recipe_input_edits,
        )


if __name__ == "__main__":
    client = Client(
        base_url="https://dev.uncountable.com",
        auth_details=AuthDetailsApiKey(
            api_id="",  # TODO
            api_secret_key="",  # TODO
        ),
    )
    with open("jobs/materials_eng_interview/UncountableFrontEndDataset.json") as file:
        data = json.load(file)
        load_data(client, data=data)

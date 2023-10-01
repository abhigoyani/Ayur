import google.generativeai as palm
import os
palm.configure(api_key=os.getenv("PALM_API_KEY"))


def symptomsDetails(symtoms):
    model = 'models/text-bison-001'
    prompt = f"""
    Suggest causes and precautions based on below symptoms if the symptoms are severe than suggest consulting doctor.
    Symptoms: {symtoms}
    output format:
    Causes:<causes>
    precautions:<precautions>   
    """
    completion = palm.generate_text(
        model=model,
        prompt=prompt,
        temperature=0,
        # The maximum length of the response
        max_output_tokens=100,
    )
    return completion.result

import $ from 'jquery';
import 'select2';

const getSelection = (category) => {
  const tempArray = [];
  $(`.select2-${category}`).select2('data').forEach(item => { tempArray.push(item.text); });
  const resultString = tempArray.join(',');
  return resultString;
};


const initSelect2 = () => {
  // COUNTRIES FILTER
  if (document.getElementById('retained-selected-countries')) {
    // Display previsously selected values (that were retained before submitting the form and reloading the page)
    const retainedSelectedCountries = document.getElementById('retained-selected-countries').dataset.retainedSelectedCountries;
    $('.select2-country').select2().val(retainedSelectedCountries.split(',')).trigger('change');
    // Submit the form whenever a change is made
    $('.select2-country').select2().on('change', function (e) {
      // We have to save the selections from the 2 other forms before submitting this one
      // (we pass them into hidden fields)
      const topicHiddenField = document.getElementById("organisation_country_topic");
      topicHiddenField.value = getSelection("topic");

      // const typeHiddenField = document.getElementById("organisation_country_type");
      // typeHiddenField.value = getSelection("type");

      const form = document.querySelector('.organisation_country');
      form.submit()
    });
  }

  //TOPICS FILTER
  if (document.getElementById('retained-selected-topics')) {
    // Display previously selected values (that were retained before submitting the form and reloading the page)
    const retainedSelectedTopics = document.getElementById('retained-selected-topics').dataset.retainedSelectedTopics;
    $('.select2-topic').select2().val(retainedSelectedTopics.split(',')).trigger('change');
    // Submit the form whenever a change is made
    $('.select2-topic').select2().on('change', function (e) {
      // We have to save the selections from the 2 other forms before submitting this one
      // (we pass them into hidden fields)
      const countryHiddenField = document.getElementById("organisation_topic_country");
      countryHiddenField.value = getSelection("country");

      // const typeHiddenField = document.getElementById("organisation_topic_type");
      // typeHiddenField.value = getSelection("type");

      const form = document.querySelector('.organisation_topic');
      form.submit();
    });
  }

  //TYPES FILTER
  // if (document.getElementById('retained-selected-types')) {
  //   // Display previously selected values (that were retained before submitting the form and reloading the page)
  //   const retainedSelectedTypes = document.getElementById('retained-selected-types').dataset.retainedSelectedTypes;
  //   console.log(retainedSelectedTypes)
  //   $('.select2-type').select2().val(retainedSelectedTypes.split(',')).trigger('change');
  //   // Submit the form whenever a change is made
  //   $('.select2-type').select2().on('change', function (e) {
  //     // We have to save the selections from the 2 other forms before submitting this one
  //     // (we pass them into hidden fields)
  //     const countryHiddenField = document.getElementById("organisation_type_country");
  //     countryHiddenField.value = getSelection("country");

  //     const topicHiddenField = document.getElementById("organisation_type_topic");
  //     topicHiddenField.value = getSelection("topic");

  //     const form = document.querySelector('.organisation_type');
  //     form.submit();
  //   });
  // }
};


export { initSelect2 };

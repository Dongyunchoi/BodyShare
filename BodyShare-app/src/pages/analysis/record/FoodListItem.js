import styled from "styled-components";
import React, { useState, useEffect, useRef } from 'react';
import seemore_dark from "../../../assets/Img/seemore_dark.png";
import seemore_white from "../../../assets/Img/seemore_white.png";
import { useRecoilValue } from 'recoil';
import { foodSelector } from "recoil/foodList";
import { isDarkAtom } from "recoil/themeRecoil";

const FoodNoteContainer = styled.div`
  display: grid;
  grid-template-columns: 1fr auto auto;
  align-items: center;
  padding: 20px;
`;

const FoodNote = styled.div`
  font-size: 14px;
`;

const Calorie = styled.p`
  font-size: 14px;
`;

const SeeMore = styled.button`
  width: 30px;
  height: 30px;
  border: none;
  cursor: pointer;
  padding: 0;
`;

const SeeMoreDetail = styled.div`
  width: 158px;
  position: relative;
`;

const SmIng = styled.img`
  width: 10px;
  height: 30px;
`;

const Delete = styled.button`
  position: absolute; 
  top: -30px;
  left: 150px;
  width: 158px;
  height: 40px;
  border-radius: 15px;
  border: 1px solid #B3B3B3;


  &:hover {
    cursor: pointer;
    background-color: #556FFF;
  }
`;

const FoodListItem = function (props) {
  const allFoods = useRecoilValue(foodSelector);
  const [isExpanded, setIsExpanded] = useState(false);
  const seeMoreDetailRef = useRef(null);
  const isDarkMode = useRecoilValue(isDarkAtom);

  let result = [];
  result = allFoods.filter(item => item.no === props.record.foodNo);

  const toggleExpansion = () => {
    setIsExpanded(!isExpanded);
  };

  const handleClickOutside = (event) => {
    if (seeMoreDetailRef.current && !seeMoreDetailRef.current.contains(event.target)) {
      setIsExpanded(false);
    }
  };

  useEffect(() => {
    if (isExpanded) {
      document.addEventListener('mousedown', handleClickOutside);
    } else {
      document.removeEventListener('mousedown', handleClickOutside);
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [isExpanded]);


  return (
    <FoodNoteContainer style={{ backgroundColor: isDarkMode ? "black" : "white" }}>
      <FoodNote>{result[0].name}</FoodNote>
      <Calorie>칼로리: {props.record.calories}kal</Calorie>
      <SeeMore onClick={toggleExpansion} style={{ backgroundColor: isDarkMode ? "black" : "white" }}>
        <SmIng src={isDarkMode ? seemore_white : seemore_dark}></SmIng>
      </SeeMore>
      {isExpanded && (
        <SeeMoreDetail ref={seeMoreDetailRef}>
          <Delete onClick={() => props.onDelete(props.record.planNo)}>
            삭제하기
          </Delete>
        </SeeMoreDetail>
      )}

    </FoodNoteContainer>
  );
};

export default FoodListItem;
